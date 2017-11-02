Received: from eggs.gnu.org ([2001:4830:134:3::10]:36638)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eAJtD-0006Xw-UH
	for qemu-devel@nongnu.org; Thu, 02 Nov 2017 14:06:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eAJt9-00006W-11
	for qemu-devel@nongnu.org; Thu, 02 Nov 2017 14:06:51 -0400
Received: from mail-wm0-f49.google.com ([74.125.82.49]:53709)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1eAJt8-000065-Qu
	for qemu-devel@nongnu.org; Thu, 02 Nov 2017 14:06:46 -0400
Received: by mail-wm0-f49.google.com with SMTP id r196so668605wmf.2
	for <qemu-devel@nongnu.org>; Thu, 02 Nov 2017 11:06:46 -0700 (PDT)
References: <20171102120223.GI32533@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <b6412d9a-77e9-9f87-8612-e14e83127da6@redhat.com>
Date: Thu, 2 Nov 2017 19:06:42 +0100
MIME-Version: 1.0
In-Reply-To: <20171102120223.GI32533@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-block] RFC: use case for adding QMP,
 block jobs & multiple exports to qemu-nbd ?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org, Eric Blake <eblake@redhat.com>

On 02/11/2017 13:02, Daniel P. Berrange wrote:
> 
> After all that long background explanation, what I'm wondering is whether
> there is any interest / desire to extend qemu-nbd to have more advanced
> featureset than simply exporting a single disk image which must be listed
> at startup time.
> 
>  - Ability to start qemu-nbd up with no initial disk image connected
>  - Option to have a QMP interface to control qemu-nbd
>  - Commands to add / remove individual disk image exports
>  - Commands for doing the drive-mirror / backing file pivot
> 
> It feels like this wouldn't require significant new functionality in either
> QMP or block layer. It ought to be mostly a cache of taking existing QMP
> code and wiring it up in qemu-nbd, and only exposing a whitelisted subset
> of existing QMP commands related to block backends. 

I think adding a QMP interface is a good idea; if you're using Unix
sockets I don't see much benefit in using multiple disk image exports
from a single qemu-nbd instance, but maybe you aren't?

At this point it does indeed feel a lot like --machine none.  Perhaps we
should just have a new binary /usr/bin/qemu-noguest instead of
augmenting qemu-nbd.

Would you also add rerror/werror support to qemu-nbd at the same time?

Paolo
