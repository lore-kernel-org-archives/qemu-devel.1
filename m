Received: from eggs.gnu.org ([2001:4830:134:3::10]:44549)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1eCl58-0000XN-3P
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 06:33:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1eCl56-0008VT-RH
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 06:33:14 -0500
Date: Thu, 9 Nov 2017 11:33:01 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20171109113301.GE17101@stefanha-x1.localdomain>
References: <68B56AECEFB25A418ADB9417F6178A531091A91B@dggemi507-mbs.china.huawei.com>
	<20171103102626.GH5078@stefanha-x1.localdomain>
	<20171106161159.GC5116@localhost.localdomain>
	<22b48478-8c86-f378-f770-095e3c297725@redhat.com>
	<20171107015930.GA16355@lemon>
	<1a034ca3-4d6d-3c44-106c-be80402c71e4@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="GxcwvYAGnODwn7V8"
Content-Disposition: inline
In-Reply-To: <1a034ca3-4d6d-3c44-106c-be80402c71e4@redhat.com>
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
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Fam Zheng <famz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, lizhengui <lizhengui@huawei.com>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>, "Fangyi (C)" <eric.fangyi@huawei.com>, "jcody@redhat.com" <jcody@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "mreitz@redhat.com" <mreitz@redhat.com>


--GxcwvYAGnODwn7V8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 07, 2017 at 11:39:44AM +0100, Paolo Bonzini wrote:
> On 07/11/2017 02:59, Fam Zheng wrote:
> > On Mon, 11/06 17:33, Paolo Bonzini wrote:
> >> On 06/11/2017 17:11, Kevin Wolf wrote:
> >>> Am 03.11.2017 um 11:26 hat Stefan Hajnoczi geschrieben:
> >>>> On Wed, Nov 01, 2017 at 06:42:33AM +0000, lizhengui wrote:
> >>>>> Hi, when I attach virtio-scsi disk to VM, the qemu crash happened a=
t very low probability.=20
> >>>>>
> >>>>> The qemu crash bt is below:
> >>>>>
> >>>>> #0  0x00007f2be3ada1d7 in raise () from /usr/lib64/libc.so.6
> >>>>> #1  0x00007f2be3adb8c8 in abort () from /usr/lib64/libc.so.6
> >>>>> #2  0x000000000084fe49 in PAT_abort ()
> >>>>> #3  0x000000000084ce8d in patchIllInsHandler ()
> >>>>> #4  <signal handler called>
> >>>>> #5  0x00000000008228bb in qemu_strnlen ()
> >>>>> #6  0x0000000000822934 in strpadcpy ()
> >>>>> #7  0x0000000000684a88 in scsi_disk_emulate_inquiry ()
> >>>>> #8  0x000000000068744b in scsi_disk_emulate_command ()
> >>>>> #9  0x000000000068c481 in scsi_req_enqueue ()
> >>>>> #10 0x00000000004b1f00 in virtio_scsi_handle_cmd_req_submit ()
> >>>>> #11 0x00000000004b2e9e in virtio_scsi_handle_cmd_vq ()
> >>>>> #12 0x000000000076dba7 in aio_dispatch ()
> >>>>> #13 0x000000000076dd96 in aio_poll ()
> >>>>> #14 0x00000000007a8673 in blk_prw ()
> >>>>> #15 0x00000000007a922c in blk_pread ()
> >>>>> #16 0x00000000007a9cd0 in blk_pread_unthrottled ()
> >>>>> #17 0x00000000005cb404 in guess_disk_lchs ()
> >>>>> #18 0x00000000005cb5b4 in hd_geometry_guess ()
> >>>>> #19 0x00000000005cad56 in blkconf_geometry ()
> >>>>> #20 0x0000000000685956 in scsi_realize ()
> >>>>> #21 0x000000000068d3e3 in scsi_qdev_realize ()
> >>>>> #22 0x00000000005e3938 in device_set_realized ()
> >>>>> #23 0x000000000075bced in property_set_bool ()
> >>>>> #24 0x0000000000760205 in object_property_set_qobject ()
> >>>>> #25 0x000000000075df64 in object_property_set_bool ()
> >>>>> #26 0x00000000005580ad in qdev_device_add ()
> >>>>> #27 0x000000000055850b in qmp_device_add ()
> >>>>> #28 0x0000000000818b37 in do_qmp_dispatch.constprop.1 ()
> >>>>> #29 0x0000000000818d8b in qmp_dispatch ()
> >>>>> #30 0x000000000045d212 in handle_qmp_command ()
> >>>>> #31 0x000000000081f819 in json_message_process_token ()
> >>>>> #32 0x00000000008434d0 in json_lexer_feed_char ()
> >>>>> #33 0x00000000008435e6 in json_lexer_feed ()
> >>>>> #34 0x000000000045bd72 in monitor_qmp_read ()
> >>>>> #35 0x000000000055ecf3 in tcp_chr_read ()
> >>>>> #36 0x00007f2be4cf899a in g_main_context_dispatch () from /usr/lib6=
4/libglib-2.0.so.0
> >>>>> #37 0x000000000076b86b in os_host_main_loop_wait ()
> >>>>> #38 0x000000000076b995 in main_loop_wait ()
> >>>>> #39 0x0000000000569c51 in main_loop ()
> >>>>> #40 0x0000000000420665 in main ()
> >>>>>
> >>>>> From the qemu crash bt, we can see that the scsi_realize has not co=
mpleted yet. Some fields sush as vendor, version in SCSIDiskState is=20
> >>>>> Null at this moment. If qemu handles scsi request from this scsi di=
sk at this moment, the qemu will access some null pointers and cause crash.
> >>>>> How can I solve this problem? Should we add a check that whether th=
e scsi disk has realized or not in scsi_disk_emulate_command before
> >>>>> Handling scsi requests?=20
> >>>>
> >>>> Please try this patch:
> >>>>
> >>>> diff --git a/hw/block/block.c b/hw/block/block.c
> >>>> index 27878d0087..df99ddb899 100644
> >>>> --- a/hw/block/block.c
> >>>> +++ b/hw/block/block.c
> >>>> @@ -120,9 +120,16 @@ void blkconf_geometry(BlockConf *conf, int *ptr=
ans,
> >>>>          }
> >>>>      }
> >>>>      if (!conf->cyls && !conf->heads && !conf->secs) {
> >>>> +        AioContext *ctx =3D blk_get_aio_context(conf->blk);
> >>>> +
> >>>> +        /* Callers may not expect this function to dispatch aio han=
dlers, so
> >>>> +         * disable external aio such as guest device emulation.
> >>>> +         */
> >>>> +        aio_disable_external(ctx);
> >>>>          hd_geometry_guess(conf->blk,
> >>>>                            &conf->cyls, &conf->heads, &conf->secs,
> >>>>                            ptrans);
> >>>> +        aio_enable_external(ctx);
> >>>>      } else if (ptrans && *ptrans =3D=3D BIOS_ATA_TRANSLATION_AUTO) {
> >>>>          *ptrans =3D hd_bios_chs_auto_trans(conf->cyls, conf->heads,=
 conf->secs);
> >>>>      }
> >>>
> >>> But why is the new disk even attached to the controller and visible to
> >>> the guest at this point when it hasn't completed its initialisation y=
et?
> >>> Isn't the root problem that we're initialising things in the wrong
> >>> order?
> >>
> >> Well, the root cause then is that scsi_device_find is just reusing the
> >> list of devices on the SCSI bus.  Devices are added to that list very
> >> early by qdev_set_parent_bus.
> >>
> >> Stefan's patch could make the issue even harder to hit, but I think th=
at
> >> with iothreads you could hit it anyway.
> >>
> >> The solution is probably to add an "online" flag to the device, and set
> >> it in scsi_device_realize.  But even that has the issue that access to
> >> the list is not protected with a lock.  What do you think?
> >=20
> > Can main thread somehow call aio_context_acquire(vs->ctx) (and release)=
 around
> > qdev_set_parent_bus()? virtio_scsi_device_find() takes the lock.
>=20
> No, the context is not set yet.  But the locking is easy to add,
> separately from the bug that Zhengui is reporting.

Do you want to submit a patch for this instead of the
aio_disable_external() approach I posted?  I think your idea is cleaner
than modifying the geometry probing function.

Stefan

--GxcwvYAGnODwn7V8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaBDztAAoJEJykq7OBq3PI+TMIAJXLvmbRxgu94vY8vOT8eO2V
+oICbZea5q4FG7kHYAqnQRI1BKk/+SVB4gowvMrHmakOJgnr2fZOSDFM3TP2H+lQ
GuZ8PKBtOuUFWwSXzshqNLTXB/ggGjQQAGFFD9lpVtZFrrSqKm6nBvd1iHx28cHP
+vjtpfJqlwrNs2RhJ8+vAGhoT5kd1Nuj8dF1IBElTu0PSwT231Oyd/bQddvnePMe
/u3EarfQZQXA1I55dxmW7D0Z8jSmbJkZXCshnFderxK0uaTkwIM0I21HEViwxFwQ
PugEF5ziP8v7vcaMRIw5LNA374LqH4nS2Adu4fctEpQo5t5rgeRSu1b/T5+oewg=
=6gRw
-----END PGP SIGNATURE-----

--GxcwvYAGnODwn7V8--
