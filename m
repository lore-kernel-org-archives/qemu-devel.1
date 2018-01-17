Received: from eggs.gnu.org ([2001:4830:134:3::10]:60564)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eboEX-0002uP-Pu
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 08:58:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eboET-0002IZ-LK
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 08:58:29 -0500
Received: from mail-qt0-x244.google.com ([2607:f8b0:400d:c0d::244]:44191)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eboET-0002IQ-Gy
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 08:58:25 -0500
Received: by mail-qt0-x244.google.com with SMTP id m59so22601257qte.11
	for <qemu-devel@nongnu.org>; Wed, 17 Jan 2018 05:58:25 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180112125000.27256-1-f4bug@amsat.org>
	<efc62dcb-cd6f-97c4-20b7-b2a4d210e55a@redhat.com>
	<20180117102527.GD19227@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <19661b12-2ac7-5253-3d6a-44c8994c18cc@amsat.org>
Date: Wed, 17 Jan 2018 10:58:21 -0300
MIME-Version: 1.0
In-Reply-To: <20180117102527.GD19227@redhat.com>
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
To: "Daniel P. Berrange" <berrange@redhat.com>, Fam Zheng <fzheng@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org

On 01/17/2018 07:25 AM, Daniel P. Berrange wrote:
> On Wed, Jan 17, 2018 at 10:26:36AM +0800, Fam Zheng wrote:
>> On 01/12/2018 08:49 PM, Philippe Mathieu-Daudé wrote:
>>> Hi,
>>>
>>> This series is to be clearer about which upstream version we are using.
>>>
>>> All "FROM distrib:latest" entries have now been removed and replaced by
>>> explicit "FROM distrib:version" ones.
>>>
>>> To keep backward compatibility, a warning is displayed to the user,
>>> suggesting which correct base image to use.
>>>
>>> To be consistent, we remove the deprecated images of the "make docker" output.
>>
>> Changing image names when a new release comes out is not maintainable for
>> Fedora and Ubuntu because of the fast pace. Therefore I prefer Paolo's
>> simple patch.
> 
> The flipside is that if we release QEMU 2.12 with fedora:27, then for as  long
> as the 2.12 stable branch exists, dockers tests run on that branch will have a
> consistent target and will be unlikely to break.  If we use fedora:latest,
> then every time a new Fedora comes out there's non-trivial chance that docker
> builds on all the stable branches will all break due to some new glibc change.
> Sticking with explicit named versions is a big win in this respect IMHO.

What happened to me twice is checking an older QEMU tag while bisecting
and being unable to run 'make docker-test' because the older QEMU tag
use 'latest' which is not the current 'latest' from the Docker library,
and I had to manually change the tag to the version 'latest' was
pointing to at the time of the QEMU tag release.

On each stable release we need to freeze the current tag in a new
Dockerfile, and keep the generic Dockerfile following the 'latest' tag.

Once tagged different that 'latest' the Dockerfile isn't suppose to
change. So we only maintain the 'latest' version.

Fam/Alex/Daniel do you agree with this approach?

Regards,

Phil.
