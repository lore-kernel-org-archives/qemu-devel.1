Received: from eggs.gnu.org ([2001:4830:134:3::10]:34043)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ely2d-0002CJ-SD
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 09:28:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ely2Z-0000UH-Ul
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 09:28:11 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:54656)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ely2Z-0000TC-NJ
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 09:28:07 -0500
Received: by mail-wm0-f67.google.com with SMTP id o189so3256972wme.4
	for <qemu-devel@nongnu.org>; Wed, 14 Feb 2018 06:28:07 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
References: <20180213173429.19501-1-stefanha@redhat.com>
	<20180213173429.19501-2-stefanha@redhat.com>
	<20180213180918.GY573@redhat.com>
	<adc8d85b-2e7c-e00e-4eba-515327e48699@redhat.com>
Message-ID: <353f9a65-82ae-f68b-1419-090ee6327d2d@redhat.com>
Date: Wed, 14 Feb 2018 15:27:55 +0100
MIME-Version: 1.0
In-Reply-To: <adc8d85b-2e7c-e00e-4eba-515327e48699@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 1/5] Add a git-publish configuration file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "=?UTF-8?Q?Daniel_P._Berrang=c3=a9?=" <berrange@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org

On 14/02/2018 15:08, Paolo Bonzini wrote:
> On 13/02/2018 19:09, Daniel P. Berrangé wrote:
>> Why is a custom entry needed for block here (and other things
>> below).   Won't running get_maintainer.pl already correctly
>> report when a patch needs cc'ing to qemu-block@nongnu.org
>> based on MAINTAINER rules ?
> 
> Sometimes you want to CC block people even on a non-block patch, for
> example if you want their opinion about using the API.
> 
> We should probably add at least arm and ppc profiles, too.

Nevermind, they were there below qemu-block.

Paolo

>> --nogit --nogit-fallback
> 
> QEMU's getmaintainer (unlike the Linux version!) already tries to avoid
> falling back to git if a maintainer is listed.  Are these options necessary?
> 
> Paolo
> 
