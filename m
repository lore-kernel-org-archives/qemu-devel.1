Received: from eggs.gnu.org ([2001:4830:134:3::10]:39987)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from <pl@kamp.de>)
	id 1cYr85-0002aW-Rr
	for qemu-devel@nongnu.org; Wed, 01 Feb 2017 04:23:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pl@kamp.de>) id 1cYr80-0000M6-UR
	for qemu-devel@nongnu.org; Wed, 01 Feb 2017 04:23:05 -0500
Received: from mx-v6.kamp.de ([2a02:248:0:51::16]:54594 helo=mx01.kamp.de)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pl@kamp.de>) id 1cYr80-0000Kg-Lx
	for qemu-devel@nongnu.org; Wed, 01 Feb 2017 04:23:00 -0500
References: <1485878172-15463-1-git-send-email-pl@kamp.de>
	<1485878172-15463-3-git-send-email-pl@kamp.de>
	<863201d4-1207-1917-0d13-3083c4cede6f@redhat.com>
From: Peter Lieven <pl@kamp.de>
Message-ID: <c8249097-e2f4-1049-6764-2cbac70a4832@kamp.de>
Date: Wed, 1 Feb 2017 10:22:55 +0100
MIME-Version: 1.0
In-Reply-To: <863201d4-1207-1917-0d13-3083c4cede6f@redhat.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH V2 2/2] block/nfs: fix naming of runtime
 opts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, eblake@redhat.com, ashijeetacharya@gmail.com, jcody@redhat.com, armbru@redhat.com, qemu-stable@nongnu.org

Am 01.02.2017 um 02:06 schrieb Max Reitz:
> On 31.01.2017 16:56, Peter Lieven wrote:
>> commit 94d6a7a accidently left the naming of runtime opts and QAPI
>> scheme inconsistent. As one consequence passing of parameters in the
>> URI is broken. Sync the naming of the runtime opts to the QAPI
>> scheme.
>>
>> Please note that this is technically backwards incompatible with the 2.8
>> release, but the 2.8 release is the only version that had the wrong naming.
>> Furthermore release 2.8 suffered from a NULL pointer deference during
>> URI parsing.
> I always love things like this. "This technically breaks X, but
> obviously nobody used X, because X always crashed." Reminds me of how we
> success^W accidentally removed qcow2 encryption.
>
> Technically however this also changes the runtime parameter names, I
> think. Giving them probably did work in 2.8, so it is not compatible
> there. I don't mind very much, though, and you're the maintainer, so
> it's fine with me.
>
> Anyway, I think this patch should also update nfs_refresh_filename().

Thanks, that indeed is missing. Will send a V3.

Peter
