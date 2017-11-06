Received: from eggs.gnu.org ([2001:4830:134:3::10]:43221)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eBk0U-0002Fl-Cd
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 11:12:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eBk0T-0004sg-8w
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 11:12:14 -0500
Date: Mon, 6 Nov 2017 17:11:59 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20171106161159.GC5116@localhost.localdomain>
References: <68B56AECEFB25A418ADB9417F6178A531091A91B@dggemi507-mbs.china.huawei.com>
	<20171103102626.GH5078@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="NzB8fVQJ5HfG6fxh"
Content-Disposition: inline
In-Reply-To: <20171103102626.GH5078@stefanha-x1.localdomain>
Subject: Re: [Qemu-devel]
 =?utf-8?q?=5BQemu-block=5D_question=EF=BC=9A_I_foun?=
 =?utf-8?q?d_a_qemu_crash_when_attach_virtio-scsi_disk?=
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: lizhengui <lizhengui@huawei.com>, "jcody@redhat.com" <jcody@redhat.com>, "mreitz@redhat.com" <mreitz@redhat.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>, "Fangyi (C)" <eric.fangyi@huawei.com>


--NzB8fVQJ5HfG6fxh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 03.11.2017 um 11:26 hat Stefan Hajnoczi geschrieben:
> On Wed, Nov 01, 2017 at 06:42:33AM +0000, lizhengui wrote:
> > Hi, when I attach virtio-scsi disk to VM, the qemu crash happened at ve=
ry low probability.=20
> >=20
> > The qemu crash bt is below:
> >=20
> > #0  0x00007f2be3ada1d7 in raise () from /usr/lib64/libc.so.6
> > #1  0x00007f2be3adb8c8 in abort () from /usr/lib64/libc.so.6
> > #2  0x000000000084fe49 in PAT_abort ()
> > #3  0x000000000084ce8d in patchIllInsHandler ()
> > #4  <signal handler called>
> > #5  0x00000000008228bb in qemu_strnlen ()
> > #6  0x0000000000822934 in strpadcpy ()
> > #7  0x0000000000684a88 in scsi_disk_emulate_inquiry ()
> > #8  0x000000000068744b in scsi_disk_emulate_command ()
> > #9  0x000000000068c481 in scsi_req_enqueue ()
> > #10 0x00000000004b1f00 in virtio_scsi_handle_cmd_req_submit ()
> > #11 0x00000000004b2e9e in virtio_scsi_handle_cmd_vq ()
> > #12 0x000000000076dba7 in aio_dispatch ()
> > #13 0x000000000076dd96 in aio_poll ()
> > #14 0x00000000007a8673 in blk_prw ()
> > #15 0x00000000007a922c in blk_pread ()
> > #16 0x00000000007a9cd0 in blk_pread_unthrottled ()
> > #17 0x00000000005cb404 in guess_disk_lchs ()
> > #18 0x00000000005cb5b4 in hd_geometry_guess ()
> > #19 0x00000000005cad56 in blkconf_geometry ()
> > #20 0x0000000000685956 in scsi_realize ()
> > #21 0x000000000068d3e3 in scsi_qdev_realize ()
> > #22 0x00000000005e3938 in device_set_realized ()
> > #23 0x000000000075bced in property_set_bool ()
> > #24 0x0000000000760205 in object_property_set_qobject ()
> > #25 0x000000000075df64 in object_property_set_bool ()
> > #26 0x00000000005580ad in qdev_device_add ()
> > #27 0x000000000055850b in qmp_device_add ()
> > #28 0x0000000000818b37 in do_qmp_dispatch.constprop.1 ()
> > #29 0x0000000000818d8b in qmp_dispatch ()
> > #30 0x000000000045d212 in handle_qmp_command ()
> > #31 0x000000000081f819 in json_message_process_token ()
> > #32 0x00000000008434d0 in json_lexer_feed_char ()
> > #33 0x00000000008435e6 in json_lexer_feed ()
> > #34 0x000000000045bd72 in monitor_qmp_read ()
> > #35 0x000000000055ecf3 in tcp_chr_read ()
> > #36 0x00007f2be4cf899a in g_main_context_dispatch () from /usr/lib64/li=
bglib-2.0.so.0
> > #37 0x000000000076b86b in os_host_main_loop_wait ()
> > #38 0x000000000076b995 in main_loop_wait ()
> > #39 0x0000000000569c51 in main_loop ()
> > #40 0x0000000000420665 in main ()
> >=20
> > From the qemu crash bt, we can see that the scsi_realize has not comple=
ted yet. Some fields sush as vendor, version in SCSIDiskState is=20
> > Null at this moment. If qemu handles scsi request from this scsi disk a=
t this moment, the qemu will access some null pointers and cause crash.
> > How can I solve this problem? Should we add a check that whether the sc=
si disk has realized or not in scsi_disk_emulate_command before
> > Handling scsi requests?=20
>=20
> Please try this patch:
>=20
> diff --git a/hw/block/block.c b/hw/block/block.c
> index 27878d0087..df99ddb899 100644
> --- a/hw/block/block.c
> +++ b/hw/block/block.c
> @@ -120,9 +120,16 @@ void blkconf_geometry(BlockConf *conf, int *ptrans,
>          }
>      }
>      if (!conf->cyls && !conf->heads && !conf->secs) {
> +        AioContext *ctx =3D blk_get_aio_context(conf->blk);
> +
> +        /* Callers may not expect this function to dispatch aio handlers=
, so
> +         * disable external aio such as guest device emulation.
> +         */
> +        aio_disable_external(ctx);
>          hd_geometry_guess(conf->blk,
>                            &conf->cyls, &conf->heads, &conf->secs,
>                            ptrans);
> +        aio_enable_external(ctx);
>      } else if (ptrans && *ptrans =3D=3D BIOS_ATA_TRANSLATION_AUTO) {
>          *ptrans =3D hd_bios_chs_auto_trans(conf->cyls, conf->heads, conf=
->secs);
>      }

But why is the new disk even attached to the controller and visible to
the guest at this point when it hasn't completed its initialisation yet?
Isn't the root problem that we're initialising things in the wrong
order?

Kevin

--NzB8fVQJ5HfG6fxh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJaAInPAAoJEH8JsnLIjy/WOhoP/RJsA4byXoc8CmbSq9OldRHO
QiuGYqUIwVj9l23DJ//nS9brkaMr+C00rRIlME5SKU99A/2HxSA00IiM+oRCohrE
NpVKABZcJLlwUSUhfbSKYriYc0Fl5BFsfVwyzkA0E6gfZCLDkeLDh3i6GyD9aNie
n8N9W96GMZmc6m5+VANRSi7jBDwPB3R/jVE7+YSRkUIB/pEgG058FEiKRk0uhage
TzLEIM+ph6CD1LRD0u57FS/c/w03CQEmk/W0vtxgVOLtL2Yq1yF05QpTb4PoAXe4
rBDgH4wuM5POmPlPYP6nb5aW/XBOgHnZqRlM30TaWXQrSjs+vhkCUWNs9801Szw3
7rp7xAigBOYWK4KrEvteGaMpXrMeh7r6Af71F5WRSS9ZmFg7kxb1h1fTe13fmLXB
ZnlCOl2wtNoYyz6txQgS+/WdiCqFA4WO5stbLuWccyoy3lNtmtf3gVRoAg3m4L+/
eWOqe8feIHOzWbdT2pKVts3Q01MLpUaslfBIEs+Cchlr3g3d0t02mkF3QspWp8eU
Zpw3potPDr5nlyHR9QxItV0cRzitNHCQG0haCaydsuol823nXhQxFC802E0IO8GD
rLDKAQKEbl3d2z7eAI1+o+bIXR+DQYPw5lt6NL0CkevR9lS8jFk28LX3BIIaYMtD
zNR0ZZOoxcI+N6WoTTeJ
=MVxJ
-----END PGP SIGNATURE-----

--NzB8fVQJ5HfG6fxh--
