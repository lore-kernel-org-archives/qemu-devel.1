Received: from eggs.gnu.org ([209.51.188.92]:35885)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1h3IA8-0006MA-Io
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 06:28:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1h3IA7-0000Cb-V7
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 06:28:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33294)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1h3IA7-0000Bb-Lk
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 06:28:03 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 2717A3688B
	for <qemu-devel@nongnu.org>; Mon, 11 Mar 2019 10:20:01 +0000 (UTC)
References: <871s3dg3si.fsf@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <3fd4f68a-9ce4-7e54-a763-ccdcf844890e@redhat.com>
Date: Mon, 11 Mar 2019 11:19:51 +0100
MIME-Version: 1.0
In-Reply-To: <871s3dg3si.fsf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] Flatview rendering scalability issue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Sergio Lopez <slp@redhat.com>, qemu-devel@nongnu.org

On 11/03/19 10:26, Sergio Lopez wrote:
> I guess this is a consequence of having to reset/rebuild the Flatview
> when altering the PCI BAR regions.
>=20
> Is this a known issue we're already working on?

What version of QEMU is this?

The initialization is O(n^2) because the guest initializes one device at
a time, so you rebuild the FlatView first with 0 devices, then 1, then
2, etc.  This is very hard to fix, if at all possible.

However, each FlatView creation should be O(n) where n is the number of
devices currently configured.  Please check with "info mtree -f" that
you only have a fixed number of FlatViews.  Old versions had one per devi=
ce.

Paolo
