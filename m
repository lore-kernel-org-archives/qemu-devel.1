Received: from eggs.gnu.org ([2001:4830:134:3::10]:51251)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fZIAJ-00060N-W7
	for qemu-devel@nongnu.org; Sat, 30 Jun 2018 11:52:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fZIAF-0005nY-VP
	for qemu-devel@nongnu.org; Sat, 30 Jun 2018 11:52:00 -0400
Received: from mail-it0-f41.google.com ([209.85.214.41]:39214)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1fZIAF-0005ji-Gw
	for qemu-devel@nongnu.org; Sat, 30 Jun 2018 11:51:55 -0400
Received: by mail-it0-f41.google.com with SMTP id p185-v6so6815098itp.4
	for <qemu-devel@nongnu.org>; Sat, 30 Jun 2018 08:51:54 -0700 (PDT)
MIME-Version: 1.0
References: <20180630061040.6018-1-pbonzini@redhat.com>
	<CAFEAcA8Fj+Ym5KdCr4iCUKy+znrhFRxNNCQDH15dHLPcg4hbOg@mail.gmail.com>
In-Reply-To: <CAFEAcA8Fj+Ym5KdCr4iCUKy+znrhFRxNNCQDH15dHLPcg4hbOg@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Sat, 30 Jun 2018 17:51:42 +0200
Message-ID: <CABgObfazhaOHnDT_Le6aPd0_SNDXOcfQrnj+zU5mf-akmyjNZA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 00/47] More misc patches for 3.0 soft freeze
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Maydell, Peter" <peter.maydell@linaro.org>
Cc: qemu-devel <qemu-devel@nongnu.org>

Hmm, must have sent a stale branch.

Thanks,

Paolo

Il sab 30 giu 2018, 17:40 Peter Maydell <peter.maydell@linaro.org> ha
scritto:

> On 30 June 2018 at 07:09, Paolo Bonzini <pbonzini@redhat.com> wrote:
> > The following changes since commit
> 109b25045b3651f9c5d02c3766c0b3ff63e6d193:
> >
> >   Merge remote-tracking branch 'remotes/bonzini/tags/for-upstream' into
> staging (2018-06-29 12:30:29 +0100)
> >
> > are available in the git repository at:
> >
> >
> >   git://github.com/bonzini/qemu.git tags/for-upstream
> >
> > for you to fetch changes up to 633e23f138f04ce776feaef78042901af883eafe=
:
> >
> >   serial: Open non-block (2018-06-29 17:31:08 +0200)
> >
> > ----------------------------------------------------------------
> > * IEC units series (Philippe)
> > * Hyper-V PV TLB flush (Vitaly)
> > * git archive detection (Daniel)
> > * host serial passthrough fix (David)
> >
>
> Compile failures I'm afraid:
>
> /root/qemu/tests/test-qemu-opts.c:707:66: error: use of undeclared
> identifier 'MiB'
>     g_assert_cmphex(qemu_opt_get_size(opts, "size3", 0), =3D=3D, 2 * MiB)=
;
>                                                                  ^
> /root/qemu/tests/test-qemu-opts.c:711:62: error: use of undeclared
> identifier 'GiB'
>     g_assert_cmphex(qemu_opt_get_size(opts, "size1", 0), =3D=3D, GiB / 10=
);
>                                                              ^
> /root/qemu/tests/test-qemu-opts.c:712:74: error: use of undeclared
> identifier 'TiB'
>     g_assert_cmphex(qemu_opt_get_size(opts, "size2", 0), =3D=3D, 16777215=
U *
> TiB);
>                                                                          =
^
> /home/petmay01/linaro/qemu-for-merges/tests/test-keyval.c: In function
> =E2=80=98test_keyval_visit_size=E2=80=99:
> /home/petmay01/linaro/qemu-for-merges/tests/test-keyval.c:460:43:
> error: =E2=80=98MiB=E2=80=99 undeclared (first use in this function)
> /home/petmay01/linaro/qemu-for-merges/tests/test-keyval.c:460:43:
> note: each undeclared identifier is reported only once for each
> function it appears in
> /home/petmay01/linaro/qemu-for-merges/tests/test-keyval.c:462:39:
> error: =E2=80=98GiB=E2=80=99 undeclared (first use in this function)
> /home/petmay01/linaro/qemu-for-merges/tests/test-keyval.c:464:50:
> error: =E2=80=98TiB=E2=80=99 undeclared (first use in this function)
>
> thanks
> -- PMM
>
>
