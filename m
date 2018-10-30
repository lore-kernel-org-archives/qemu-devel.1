Received: from eggs.gnu.org ([2001:4830:134:3::10]:51656)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1gHU7g-0003OB-Mz
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 09:31:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1gHU7W-0003fr-PD
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 09:31:53 -0400
Received: from mail-it1-x142.google.com ([2607:f8b0:4864:20::142]:52435)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <liq3ea@gmail.com>) id 1gHU7W-0003ev-EQ
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 09:31:46 -0400
Received: by mail-it1-x142.google.com with SMTP id r5-v6so11685865ith.2
	for <qemu-devel@nongnu.org>; Tue, 30 Oct 2018 06:31:46 -0700 (PDT)
MIME-Version: 1.0
References: <1540873732-3503-1-git-send-email-liq3ea@gmail.com>
	<1540873732-3503-3-git-send-email-liq3ea@gmail.com>
	<8554a03c-4409-c7f5-bd9e-613d03779e73@redhat.com>
In-Reply-To: <8554a03c-4409-c7f5-bd9e-613d03779e73@redhat.com>
From: Li Qiang <liq3ea@gmail.com>
Date: Tue, 30 Oct 2018 21:31:08 +0800
Message-ID: <CAKXe6S+VVucg1khc1Wk-QYnJOy6j92+5LJ22FMxOspa3Q-Duyg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 2/2] tests: fw_cfg: add reboot_timeout
 test case
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: thuth@redhat.com, lvivier@redhat.com, philmd@redhat.com, Qemu Developers <qemu-devel@nongnu.org>

Hi Paolo,

Paolo Bonzini <pbonzini@redhat.com> =E4=BA=8E2018=E5=B9=B410=E6=9C=8830=E6=
=97=A5=E5=91=A8=E4=BA=8C =E4=B8=8B=E5=8D=886:52=E5=86=99=E9=81=93=EF=BC=9A

> On 30/10/2018 05:28, Li Qiang wrote:
> > Signed-off-by: Li Qiang <liq3ea@gmail.com>
> > ---
> >  tests/fw_cfg-test.c | 10 ++++++++++
> >  1 file changed, 10 insertions(+)
> >
> > diff --git a/tests/fw_cfg-test.c b/tests/fw_cfg-test.c
> > index 1c5103fe1c..aeabd17ec0 100644
> > --- a/tests/fw_cfg-test.c
> > +++ b/tests/fw_cfg-test.c
> > @@ -99,6 +99,15 @@ static void test_fw_cfg_boot_menu(void)
> >      g_assert_cmpint(qfw_cfg_get_u16(fw_cfg, FW_CFG_BOOT_MENU), =3D=3D,
> boot_menu);
> >  }
> >
> > +static void test_fw_cfg_reboot_timeout(void)
> > +{
> > +    uint32_t reboot_timeout;
> > +
> > +    qfw_cfg_get_file(fw_cfg, "etc/boot-fail-wait",
> > +                     &reboot_timeout, sizeof(reboot_timeout));
> > +    g_assert_cmpint(reboot_timeout, <=3D, 65535);
> > +}
> > +
> >  int main(int argc, char **argv)
> >  {
> >      QTestState *s;
> > @@ -125,6 +134,7 @@ int main(int argc, char **argv)
> >      qtest_add_func("fw_cfg/max_cpus", test_fw_cfg_max_cpus);
> >      qtest_add_func("fw_cfg/numa", test_fw_cfg_numa);
> >      qtest_add_func("fw_cfg/boot_menu", test_fw_cfg_boot_menu);
> > +    qtest_add_func("fw_cfg/reboot_timeout", test_fw_cfg_reboot_timeout=
);
> >
> >      ret =3D g_test_run();
>
> This test is not doing much; you could add "-boot reboot-timeout=3D15" an=
d
> check the value.
>
>
This test is for this fix:
https://lists.gnu.org/archive/html/qemu-devel/2018-10/msg05254.html
As the reboot_timeout will be negative.

May I add another  "-boot reboot-timeout=3D15"  test?

Thanks,
Li QIang


> Paolo
>
>
