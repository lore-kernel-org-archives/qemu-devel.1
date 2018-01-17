Received: from eggs.gnu.org ([2001:4830:134:3::10]:56371)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ebo3w-0006So-UG
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 08:47:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ebo3s-0002YM-U7
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 08:47:32 -0500
Received: from mail-vk0-x244.google.com ([2607:f8b0:400c:c05::244]:37458)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ebo3s-0002Xz-P6
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 08:47:28 -0500
Received: by mail-vk0-x244.google.com with SMTP id g83so11509276vki.4
	for <qemu-devel@nongnu.org>; Wed, 17 Jan 2018 05:47:28 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180112125000.27256-1-f4bug@amsat.org>
	<efc62dcb-cd6f-97c4-20b7-b2a4d210e55a@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <725d8315-8dce-3465-7f5c-77f467d65a37@amsat.org>
Date: Wed, 17 Jan 2018 10:47:19 -0300
MIME-Version: 1.0
In-Reply-To: <efc62dcb-cd6f-97c4-20b7-b2a4d210e55a@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 0/7] docker: update Ubuntu and Fedora
 images, deprecate old ones
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <fzheng@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org

On 01/16/2018 11:26 PM, Fam Zheng wrote:
> On 01/12/2018 08:49 PM, Philippe Mathieu-Daudé wrote:
>> Hi,
>>
>> This series is to be clearer about which upstream version we are using.
>>
>> All "FROM distrib:latest" entries have now been removed and replaced by
>> explicit "FROM distrib:version" ones.
>>
>> To keep backward compatibility, a warning is displayed to the user,
>> suggesting which correct base image to use.
>>
>> To be consistent, we remove the deprecated images of the "make docker"
>> output.
> 
> Changing image names when a new release comes out is not maintainable
> for Fedora and Ubuntu because of the fast pace. Therefore I prefer
> Paolo's simple patch.
> 
> Maybe you can somehow create an alias in Makefile to point "fedora" to
> "fedora${last_release_num}", and update it when adding a new release.
> But still I don't think keeping more than one fedora dockerfiles is very
> useful.
> 
> In principle, we use Debian, CentOS and ubuntu-lts to cover long living
> releases and {ubuntu,fedora}:latest to cover cutting edge releases.
> Spending effort on tests is better than adding more versions, IMO.

I went this way following your previous advice in
http://lists.nongnu.org/archive/html/qemu-devel/2017-07/msg05282.html
but I get your point.
