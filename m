Received: from eggs.gnu.org ([2001:4830:134:3::10]:39255)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wainersm@redhat.com>) id 1gNIpv-0001nr-5U
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 09:41:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wainersm@redhat.com>) id 1gNIpX-0000XU-5s
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 09:41:29 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49282)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wainersm@redhat.com>) id 1gNIpW-0000Vt-UB
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 09:41:15 -0500
References: <20181109182153.5390-1-wainersm@redhat.com>
	<dbde7c87-b0b2-becc-0176-609befb40e1a@redhat.com>
From: Wainer dos Santos Moschetta <wainersm@redhat.com>
Message-ID: <450af60f-0da2-0b53-0ac3-10ceb90fc417@redhat.com>
Date: Thu, 15 Nov 2018 12:41:09 -0200
MIME-Version: 1.0
In-Reply-To: <dbde7c87-b0b2-becc-0176-609befb40e1a@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2] Acceptance tests: add Linux initrd
 checking test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org, ehabkost@redhat.com
Cc: crosa@redhat.com, philmd@redhat.com, lizhijian@cn.fujitsu.com, ccarrara@redhat.com

Hi Eduardo,

Since you have already queued this patch for 4.0, I would like to know=20
if I should send a v3 to address Eric's review. Or if you can edit the=20
patch yourself given the changes are trivial.

Thanks!
- Wainer

On 11/13/2018 02:08 PM, Eric Blake wrote:
> On 11/9/18 12:21 PM, Wainer dos Santos Moschetta wrote:
>> QEMU used to exits with a not accurate error message when
>
> s/exits/exit/
> s/a not accurate/an inaccurate/
>
>> an initrd > 2GiB was passed. That was fixed on patch:
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0commit f3839fda5771596152b75dd1e1a6d050e6e6e38=
0
>> =C2=A0=C2=A0=C2=A0=C2=A0Author: Li Zhijian <lizhijian@cn.fujitsu.com>
>> =C2=A0=C2=A0=C2=A0=C2=A0Date:=C2=A0=C2=A0 Thu Sep 13 18:07:13 2018 +08=
00
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 change get_image_size=
 return type to int64_t
>>
>> This change adds a regression test for that fix. It starts
>> QEMU with a 2GiB dummy initrd, and check it evaluates the file
>
> s/check/checks that/
>
>> size correctly and prints accurate message.
>
> s/accurate/an accurate/
>
>>
>> Signed-off-by: Wainer dos Santos Moschetta <wainersm@redhat.com>
>> Reviewed-by: Caio Carrara <ccarrara@redhat.com>
>> Reviewed-by: Cleber Rosa <crosa@redhat.com>
>> Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
>> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>> Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>> ---
>
>
