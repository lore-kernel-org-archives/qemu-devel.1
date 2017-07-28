Received: from eggs.gnu.org ([2001:4830:134:3::10]:33220)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dazDi-0008DR-6t
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 02:57:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dazDd-0005ap-Vk
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 02:57:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60914)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1dazDd-0005aJ-P6
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 02:57:53 -0400
Message-ID: <1501225071.10943.3.camel@redhat.com>
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Fri, 28 Jul 2017 08:57:51 +0200
In-Reply-To: <70092179-8b4b-8f6d-50bc-df95ad2649be@redhat.com>
References: <CAGCz3vu5x59+mKg8011=DRyZQKbuBV2F20ZpPnG1TOCxsOb+mQ@mail.gmail.com>
	<CAGCz3vvBDC0cYY_kmgoCn1D1j9RLAda646n_NTuVq6PQF1qNmw@mail.gmail.com>
	<9767baed-582d-8aab-f9a6-0d04d7ec9d23@redhat.com>
	<165445ef-c2fb-f49e-8185-2a8af0e27bf2@redhat.com>
	<a92581c5-87b8-26d0-15d3-33ea6e87d442@redhat.com>
	<20170725220150.GA2891@morn.lan>
	<8ce79be9-5512-148d-f2d4-3bb8c04d6eda@redhat.com>
	<20170726191252.GA8769@morn.lan>
	<1419439438.19249924.1501100483485.JavaMail.zimbra@redhat.com>
	<20170727145929.GA14721@morn.lan>
	<70092179-8b4b-8f6d-50bc-df95ad2649be@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [SeaBIOS] Commit
 77af8a2b95b79699de650965d5228772743efe84 breaks Windows 2000 support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laszlo Ersek <lersek@redhat.com>, Kevin O'Connor <kevin@koconnor.net>, Paolo Bonzini <pbonzini@redhat.com>
Cc: Phil Dennis-Jordan <phil@philjordan.eu>, seabios@seabios.org, "qemu-devel@nongnu.org qemu-devel" <qemu-devel@nongnu.org>, Programmingkid <programmingkidx@gmail.com>, Phil Dennis-Jordan <lists@philjordan.eu>, Richard Henderson <rth@twiddle.net>

  Hi,

> It's a good goal.
> 
> I apologize for forgetting the context, but what exactly was the
> argument against:
> 
> - splitting modern ACPI generation from ancient ACPI generation (so
> that
> we can assign separate maintainers to ancient vs. modern),
> 
> - restricting ancient ACPI generation to old machine types?

I think this is the only sensible solution for 2.10:  Have "pc" provide
a rev1 FADT and "q35" provide a rev3 FADT.

Or just revert the rev3 FADT patch and try again in the 2.11 devel
cycle.

We are in qemu freeze and we don't even have a clear plan yet how to
implement the "RSDT points to rev1 and XSDT points to rev3" thing,
which IMO is a clear indicator that it isn't 2.10 material.

Beside that I'll be in my summer vacation next three weeks, so I can't
take care to create a seabios 1.10.3 release and update qemu ...

cheers,
  Gerd
