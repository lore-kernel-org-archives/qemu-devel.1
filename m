Received: from eggs.gnu.org ([2001:4830:134:3::10]:37922)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1da2cP-0007Ck-Cf
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 12:23:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1da2cL-0000BU-DS
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 12:23:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58352)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1da2cL-0000Aw-7H
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 12:23:29 -0400
References: <3E24AFDE-D25A-416B-A600-3C2221C3A9F1@gmail.com>
	<CAGCz3vu5x59+mKg8011=DRyZQKbuBV2F20ZpPnG1TOCxsOb+mQ@mail.gmail.com>
	<20170721110636.19412e6c@nial.brq.redhat.com>
	<20170721092338.GE17693@redhat.com>
	<20170721143432.0e888800@nial.brq.redhat.com>
	<CAGCz3vvBDC0cYY_kmgoCn1D1j9RLAda646n_NTuVq6PQF1qNmw@mail.gmail.com>
	<9767baed-582d-8aab-f9a6-0d04d7ec9d23@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <165445ef-c2fb-f49e-8185-2a8af0e27bf2@redhat.com>
Date: Tue, 25 Jul 2017 18:23:22 +0200
MIME-Version: 1.0
In-Reply-To: <9767baed-582d-8aab-f9a6-0d04d7ec9d23@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] Commit 77af8a2b95b79699de650965d5228772743efe84
 breaks Windows 2000 support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laszlo Ersek <lersek@redhat.com>, Phil Dennis-Jordan <lists@philjordan.eu>, Igor Mammedov <imammedo@redhat.com>
Cc: "Daniel P. Berrange" <berrange@redhat.com>, Phil Dennis-Jordan <phil@philjordan.eu>, ehabkost@redhat.com, "qemu-devel@nongnu.org qemu-devel" <qemu-devel@nongnu.org>, Programmingkid <programmingkidx@gmail.com>, Richard Henderson <rth@twiddle.net>

On 25/07/2017 18:14, Laszlo Ersek wrote:
>   "No regressions became apparent in tests with a range of Windows
>    (XP-10)"
> 
> In theory, w2k falls within that range.

Nope, Windows 2000 is like NT 5.0, XP is like NT 5.1. :(

One possibility is to fix it in SeaBIOS instead: if you get a 2.0 FADT
and an XSDT and no RSDT, it can build an RSDT and a 1.0 FADT itself,
patching the RSDT to point to it.

It's a hack, but it's the only place I see to make it "just work".  And
it could be extended nicely in the future.

All QEMU would have to do is to provide an XSDT _instead_ of an RSDT.

Paolo

> In practice, it is impossible to
> test *all* Windows versions against ACPI generator changes, even if you
> try to be thorough (which Phil was). One might not even *know about*
> "all" Windows versions. So people using w2k and similar should
> co-maintain the ACPI stuff and report back with testing on the fly;
> otherwise regressions are impossible to avoid.
