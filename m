Received: from eggs.gnu.org ([2001:4830:134:3::10]:56031)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aishwaryakadlag@gmail.com>) id 1euVWx-0005WJ-Rf
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 22:51:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aishwaryakadlag@gmail.com>) id 1euVWa-0005jC-Aq
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 22:50:47 -0500
Received: from mail-ot0-x22f.google.com ([2607:f8b0:4003:c0f::22f]:41549)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aishwaryakadlag@gmail.com>)
	id 1euVWZ-0005iP-G4
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 22:50:24 -0500
Received: by mail-ot0-x22f.google.com with SMTP id w38so10546298ota.8
	for <qemu-devel@nongnu.org>; Fri, 09 Mar 2018 19:50:23 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <mailman.30324.1520635411.27991.qemu-devel@nongnu.org>
References: <mailman.30324.1520635411.27991.qemu-devel@nongnu.org>
From: Aishwarya Kadlag <aishwaryakadlag@gmail.com>
Date: Sat, 10 Mar 2018 09:20:20 +0530
Message-ID: <CAFPFVbdhAW2JTsjGuGeOajqaZVh-yxmizrSMbKaLpGuAvzQ2jg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] Qemu-devel Digest, Vol 180, Issue 211
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

I want to contribute to QEMU as a developer. I have worked on ARM Cortex
board and implemented its peripherals. I have gone through QEMU and
micro_bit board documentation. But I am not able to understand what I am
exactly supposed to do to complete any bite sized tasks. Please help me
with this.

On Sat, Mar 10, 2018 at 4:13 AM, <qemu-devel-request@nongnu.org> wrote:

> Send Qemu-devel mailing list submissions to
>         qemu-devel@nongnu.org
>
> To subscribe or unsubscribe via the World Wide Web, visit
>         https://lists.nongnu.org/mailman/listinfo/qemu-devel
> or, via email, send a message with subject or body 'help' to
>         qemu-devel-request@nongnu.org
>
> You can reach the person managing the list at
>         qemu-devel-owner@nongnu.org
>
> When replying, please edit your Subject line so it is more specific
> than "Re: Contents of Qemu-devel digest..."
>
>
> Today's Topics:
>
>    1. [PATCH v2] fsl-imx6: Swap Ethernet interrupt defines
>       (Guenter Roeck)
>    2. Re: Apparently fpu/softfloat.c:1374 is reachable (Emilio G. Cota)
>    3. Re: [PATCH 3/5] nbd/server: fix: check client->closing before
>       reply sending (Eric Blake)
>    4. Re: [PATCH 4/6] luks: Turn invalid assertion into check
>       (Kevin Wolf)
>    5. Re: [PATCH 3/7] qcow: Support .bdrv_co_create (Eric Blake)
>    6. [Bug 1726733] Re: ?qemu-img info replication:? causes
>       segfault (Fabiano Rosas)
>    7. Re: [PATCH 4/7] qed: Support .bdrv_co_create (Eric Blake)
>    8. Re: [PATCH] qemu-doc: Rework the network options chapter to
>       make "-net" less prominent (Thomas Huth)
>    9. Re: [PATCH 4/5] nbd/server: refactor nbd_trip: cmd_read and
>       generic reply (Eric Blake)
>   10. Re: [PATCH 5/5] nbd/server: refactor nbd_trip: split out
>       nbd_handle_request (Eric Blake)
>   11. Re: Apparently fpu/softfloat.c:1374 is reachable (Palmer Dabbelt)
>   12. Re: [PATCH] qemu-doc: Rework the network options chapter to
>       make "-net" less prominent (Eric Blake)
>   13. Re: [PATCH v2 1/3] scripts/update-linux-headers: add
>       ethtool.h and update to 4.16.0-rc4 (Michael S. Tsirkin)
>
>
> ----------------------------------------------------------------------
>
> Message: 1
> Date: Fri,  9 Mar 2018 13:47:03 -0800
> From: Guenter Roeck <linux@roeck-us.net>
> To: Peter Maydell <peter.maydell@linaro.org>
> Cc: Peter Chubb <peter.chubb@nicta.com.au>, Jason Wang
>         <jasowang@redhat.com>,  qemu-arm@nongnu.org, qemu-devel@nongnu.org
> ,
>         Andrey Smirnov <andrew.smirnov@gmail.com>, Chris Healy
>         <cphealy@gmail.com>,    Bill Paul <wpaul@windriver.com>, Guenter
> Roeck
>         <linux@roeck-us.net>
> Subject: [Qemu-devel] [PATCH v2] fsl-imx6: Swap Ethernet interrupt
>         defines
> Message-ID: <1520632024-31535-1-git-send-email-linux@roeck-us.net>
>
> The sabrelite machine model used by qemu-system-arm is based on the
> Freescale/NXP i.MX6Q processor. This SoC has an on-board ethernet
> controller which is supported in QEMU using the imx_fec.c module
> (actually called imx.enet for this model.)
>
> The include/hw/arm/fsm-imx6.h file defines the interrupt vectors for the
> imx.enet device like this:
>
>  #define FSL_IMX6_ENET_MAC_1588_IRQ 118
>  #define FSL_IMX6_ENET_MAC_IRQ 119
>
> According to https://www.nxp.com/docs/en/reference-manual/IMX6DQRM.pdf,
> page 225, in Table 3-1. ARM Cortex A9 domain interrupt summary,
> interrupts are as follows.
>
> 150 ENET MAC 0 IRQ
> 151 ENET MAC 0 1588 Timer interrupt
>
> where
>
> 150 - 32 == 118
> 151 - 32 == 119
>
> In other words, the vector definitions in the fsl-imx6.h file are reversed.
>
> Fixing the interrupts alone causes problems with older Linux kernels:
> The Ethernet interface will fail to probe with Linux v4.9 and earlier.
> Linux v4.1 and earlier will crash due to a bug in Ethernet driver probe
> error handling. This is a Linux kernel problem, not a qemu problem:
> the Linux kernel only worked by accident since it requested both
> interrupts.
>
> For backward compatibility, generate the Ethernet interrupt on both
> interrupt
> lines. This was shown to work from all Linux kernel releases starting with
> v3.16.
>
> Link: https://bugs.launchpad.net/qemu/+bug/1753309
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
> v2: Generate Ethernet interrupts on both interrupt lines
>
>  hw/net/imx_fec.c          | 7 ++++++-
>  include/hw/arm/fsl-imx6.h | 4 ++--
>  2 files changed, 8 insertions(+), 3 deletions(-)
>
> diff --git a/hw/net/imx_fec.c b/hw/net/imx_fec.c
> index 9506f9b..d3ae7db 100644
> --- a/hw/net/imx_fec.c
> +++ b/hw/net/imx_fec.c
> @@ -417,7 +417,12 @@ static void imx_enet_write_bd(IMXENETBufDesc *bd,
> dma_addr_t addr)
>
>  static void imx_eth_update(IMXFECState *s)
>  {
> -    if (s->regs[ENET_EIR] & s->regs[ENET_EIMR] & ENET_INT_TS_TIMER) {
> +    /*
> +     * Generate ENET_INT_MAC interrrupts on both interrupt lines for
> +     * backward compatibility with Linux kernel versions 4.9 and older.
> +     */
> +    if (s->regs[ENET_EIR] & s->regs[ENET_EIMR] &
> +        (ENET_INT_MAC | ENET_INT_TS_TIMER)) {
>          qemu_set_irq(s->irq[1], 1);
>      } else {
>          qemu_set_irq(s->irq[1], 0);
> diff --git a/include/hw/arm/fsl-imx6.h b/include/hw/arm/fsl-imx6.h
> index ec6c509..06f8aae 100644
> --- a/include/hw/arm/fsl-imx6.h
> +++ b/include/hw/arm/fsl-imx6.h
> @@ -438,8 +438,8 @@ typedef struct FslIMX6State {
>  #define FSL_IMX6_HDMI_MASTER_IRQ 115
>  #define FSL_IMX6_HDMI_CEC_IRQ 116
>  #define FSL_IMX6_MLB150_LOW_IRQ 117
> -#define FSL_IMX6_ENET_MAC_1588_IRQ 118
> -#define FSL_IMX6_ENET_MAC_IRQ 119
> +#define FSL_IMX6_ENET_MAC_IRQ 118
> +#define FSL_IMX6_ENET_MAC_1588_IRQ 119
>  #define FSL_IMX6_PCIE1_IRQ 120
>  #define FSL_IMX6_PCIE2_IRQ 121
>  #define FSL_IMX6_PCIE3_IRQ 122
> --
> 2.7.4
>
>
>
>
> ------------------------------
>
> Message: 2
> Date: Fri, 9 Mar 2018 16:49:57 -0500
> From: "Emilio G. Cota" <cota@braap.org>
> To: Michael Clark <mjc@sifive.com>
> Cc: Peter Maydell <peter.maydell@linaro.org>,   Stefan O'Rear
>         <sorear2@gmail.com>,    Richard Henderson <
> richard.henderson@linaro.org>,
>         QEMU Developers <qemu-devel@nongnu.org>
> Subject: Re: [Qemu-devel] Apparently fpu/softfloat.c:1374 is reachable
> Message-ID: <20180309214957.GA32140@flamenco>
> Content-Type: text/plain; charset=utf-8
>
> On Fri, Mar 09, 2018 at 11:34:56 +0000, Michael Clark wrote:
> > BTW how does one hide signed-off-by or cc email addresses with the
> > git-send-email workflow?
>
> You just don't.
>
> > Seems like editing the patch after git format-patch is likely the only
> way
> > around for contributors whose wishes I might not have honoured, except
> > originally when I was using an advoc albeit buggy workflow, where the
> Cc?s
> > et all we?re later added to the patch headers and not the commits. I?ve
> > probably inadvertently violated someone?s wish to keep their email
> address
> > out of the list archives, which is an understandable wish.
>
> If that's their wish I'd say just use the --cc flag; they get to keep
> their address hidden from public commit messages, at the expense of
> (possibly)
> being Cc'ed on more emails than they need to. I think it's a
> reasonable trade-off.
>
> That said, if they really want to hide their address from others,
> you should use --bcc. But then they wouldn't receive the replies.
>
> > This is not an issue with GitHub PR?s as they keep identity information
> > differently however slicing up the port for upstreaming has lost some of
> > our contributor history. I have made tags before every squash and rebase
> so
> > we can find all history in the riscv repo, as well as previously trying
> to
> > keep personal emails out of the cover letters in the first series. With
> the
> > change to the git-sendemail  workflow i?ve likely regressed here.
> >
> > I also probably have to manually edit patches to add ?Cc to the
> > riscv-patches mailing list, as it doesn?t seem right to put that email in
> > the commit messages.
>
> Isn't Cc'ing riscv-patches an obvious use case for using the --cc flag?
> (BTW You can add as many --cc's as you want, and these apply to all patches
> in a series.)
>
>                 E.
>
> PS. As always, remember to use --dry-run =)
>
>
>
> ------------------------------
>
> Message: 3
> Date: Fri, 9 Mar 2018 15:51:18 -0600
> From: Eric Blake <eblake@redhat.com>
> To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
>         qemu-devel@nongnu.org, qemu-block@nongnu.org
> Cc: pbonzini@redhat.com, den@openvz.org
> Subject: Re: [Qemu-devel] [PATCH 3/5] nbd/server: fix: check
>         client->closing before reply sending
> Message-ID: <bc19fbc1-71b9-59cd-2556-3b388a886091@redhat.com>
> Content-Type: text/plain; charset=utf-8; format=flowed
>
> On 03/08/2018 12:46 PM, Vladimir Sementsov-Ogievskiy wrote:
> > Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> > ---
> >
> > It's like an RFC. I'm not sure, but this place looks like a bug.
> Shouldn't
> > we chack client-closing even before nbd_client_receive_next_request()
> call?
> >
> >   nbd/server.c | 8 ++++----
> >   1 file changed, 4 insertions(+), 4 deletions(-)
> >
> > diff --git a/nbd/server.c b/nbd/server.c
> > index e0de431e10..97b45a21fa 100644
> > --- a/nbd/server.c
> > +++ b/nbd/server.c
> > @@ -1547,10 +1547,6 @@ static coroutine_fn void nbd_trip(void *opaque)
>
> More context:
>
>      ret = nbd_co_receive_request(req, &request, &local_err);
>      client->recv_coroutine = NULL;
>      nbd_client_receive_next_request(client);
>      if (ret == -EIO) {
>
> >           goto disconnect;
> >       }
> >
>
> Calling nbd_client_receive_next_request() checks whether recv_coroutine
> is NULL (it is, because we just set it that way) and whether we are up
> to our maximum in parallel request handling; so it likely queues another
> coroutine to call nbd_trip() again.  However, when the next nbd_trip()
> is invoked, the first thing it does (after a trace call) is check
> client->closing, at which point it is a nop.
>
> Your argument is that if ret was -EIO, we goto disconnect (which sets
> client->closing if it was not already set), and thus the just-scheduled
> next nbd_trip() will be a nop.  If ret was anything else, we used to try
> to reply to the client no matter what, which generally works; although
> if client->closing is already set, the attempt to reply is instead
> likely to fail and result in a later attempt to goto disconnect - but at
> that point disconnect is a nop since client->closing is already set.
> Whereas your patch skips the reply to the client if client->closing (and
> can't reach the disconnect code, but that doesn't matter as the
> disconnect attempt did nothing).  Swapping the check for client->closing
> to be earlier than the reply to the client thus looks safe.
>
> Your RFC question is whether we can just check client->closing before
> checking ret, and skip nbd_client_receive_next_request() in that case
> (in other words, why even bother to queue up a coroutine that will do
> nothing, if we already know the client is going away).  And my answer is
> yes, I think that makes more sense.  So that would be:
>
> diff --git c/nbd/server.c w/nbd/server.c
> index 5f292064af0..b230ecb4fb8 100644
> --- c/nbd/server.c
> +++ w/nbd/server.c
> @@ -1543,14 +1543,6 @@ static coroutine_fn void nbd_trip(void *opaque)
>       req = nbd_request_get(client);
>       ret = nbd_co_receive_request(req, &request, &local_err);
>       client->recv_coroutine = NULL;
> -    nbd_client_receive_next_request(client);
> -    if (ret == -EIO) {
> -        goto disconnect;
> -    }
> -
> -    if (ret < 0) {
> -        goto reply;
> -    }
>
>       if (client->closing) {
>           /*
> @@ -1560,6 +1552,15 @@ static coroutine_fn void nbd_trip(void *opaque)
>           goto done;
>       }
>
> +    nbd_client_receive_next_request(client);
> +    if (ret == -EIO) {
> +        goto disconnect;
> +    }
> +
> +    if (ret < 0) {
> +        goto reply;
> +    }
> +
>       switch (request.type) {
>       case NBD_CMD_READ:
>           /* XXX: NBD Protocol only documents use of FUA with WRITE */
>
>
> Unless this revised form fails testing or gets any other review
> comments, I will go ahead and amend your commit in this manner.
>
> --
> Eric Blake, Principal Software Engineer
> Red Hat, Inc.           +1-919-301-3266
> Virtualization:  qemu.org | libvirt.org
>
>
>
> ------------------------------
>
> Message: 4
> Date: Fri, 9 Mar 2018 22:55:12 +0100
> From: Kevin Wolf <kwolf@redhat.com>
> To: Eric Blake <eblake@redhat.com>
> Cc: qemu-block@nongnu.org, mreitz@redhat.com, berrange@redhat.com,
>         qemu-devel@nongnu.org
> Subject: Re: [Qemu-devel] [PATCH 4/6] luks: Turn invalid assertion
>         into check
> Message-ID: <20180309215512.GA8198@localhost.localdomain>
> Content-Type: text/plain; charset=us-ascii
>
> Am 09.03.2018 um 21:19 hat Eric Blake geschrieben:
> > On 03/09/2018 11:27 AM, Kevin Wolf wrote:
> > > The .bdrv_getlength implementation of the crypto block driver asserted
> > > that the payload offset isn't after EOF. This is an invalid assertion
> to
> > > make as the image file could be corrupted. Instead, check it and return
> > > -EIO if the file is too small for the payload offset.
> >
> > Good catch.  Probably not a CVE (unless someone can argue some way that
> > causing a crash on an attempt to load a maliciously corrupted file can be
> > used as a denial of service across a privilege boundary), but definitely
> > needs fixing.
> >
> > >
> > > Zero length images are fine, so trigger -EIO only on offset > len, not
> > > on offset >= len as the assertion did before.
> > >
> > > Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> > > ---
> > >   block/crypto.c | 5 ++++-
> > >   1 file changed, 4 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/block/crypto.c b/block/crypto.c
> > > index 2035f9ab13..4908d8627f 100644
> > > --- a/block/crypto.c
> > > +++ b/block/crypto.c
> > > @@ -518,7 +518,10 @@ static int64_t block_crypto_getlength(BlockDriverState
> *bs)
> > >       uint64_t offset = qcrypto_block_get_payload_
> offset(crypto->block);
> > >       assert(offset < INT64_MAX);
> >
> > Umm, if the file can be corrupted, what's to prevent someone from
> sticking
> > in a negative size that fails this assertion?
>
> In qcrypto_block_luks_open():
>
>     block->sector_size = QCRYPTO_BLOCK_LUKS_SECTOR_SIZE;
>     block->payload_offset = luks->header.payload_offset *
>             block->sector_size
>
> The sector size is 512LL, and luks->header.payload_offset is 32 bit.
>
> But I just saw that block_crypto_truncate() has another wrong assertion.
> Maybe I should fix that and write a test case for it. Not sure if I'll
> add it to this series or as a follow-up during the freeze.
>
> Kevin
>
>
>
> ------------------------------
>
> Message: 5
> Date: Fri, 9 Mar 2018 15:58:55 -0600
> From: Eric Blake <eblake@redhat.com>
> To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
> Cc: mreitz@redhat.com, den@openvz.org, jcody@redhat.com,
>         qemu-devel@nongnu.org
> Subject: Re: [Qemu-devel] [PATCH 3/7] qcow: Support .bdrv_co_create
> Message-ID: <fb503893-a9e0-2772-41f2-14934b199f8d@redhat.com>
> Content-Type: text/plain; charset=utf-8; format=flowed
>
> On 03/09/2018 03:46 PM, Kevin Wolf wrote:
> > This adds the .bdrv_co_create driver callback to qcow, which
> > enables image creation over QMP.
> >
> > Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> > ---
> >   qapi/block-core.json |  21 +++++-
> >   block/qcow.c         | 196 ++++++++++++++++++++++++++++++
> ++++-----------------
> >   2 files changed, 150 insertions(+), 67 deletions(-)
>
> Pre-review question: do we REALLY want to support creation of new qcow
> images from QMP?  Or are we at the point where we want to declare qcow a
> read-only format where we only support it to the extent that you can
> convert an existing qcow file into a better supported format like qcow2?
>
> --
> Eric Blake, Principal Software Engineer
> Red Hat, Inc.           +1-919-301-3266
> Virtualization:  qemu.org | libvirt.org
>
>
>
> ------------------------------
>
> Message: 6
> Date: Fri, 09 Mar 2018 21:53:26 -0000
> From: Fabiano Rosas <1726733@bugs.launchpad.net>
> To: qemu-devel@nongnu.org
> Subject: [Qemu-devel] [Bug 1726733] Re: ?qemu-img info replication:?
>         causes segfault
> Message-ID:
>         <152063240736.14498.11495166445414966902.launchpad@chaenomeles.
> canonical.com>
>
> Content-Type: text/plain; charset="utf-8"
>
> ** Changed in: qemu
>        Status: New => In Progress
>
> --
> You received this bug notification because you are a member of qemu-
> devel-ml, which is subscribed to QEMU.
> https://bugs.launchpad.net/bugs/1726733
>
> Title:
>   ?qemu-img info replication:? causes segfault
>
> Status in QEMU:
>   In Progress
>
> Bug description:
>   Typing the literal command ?qemu-img info replication:? causes a
>   segfault.  Note that ?replication:? is not a filename.
>
>   $ ./qemu-img info replication:
>   qemu-img: block.c:2609: bdrv_open_inherit: Assertion `!!(flags &
> BDRV_O_PROTOCOL) == !!drv->bdrv_file_open' failed.
>   Aborted (core dumped)
>
>   This was originally found by Han Han and reported in Fedora:
>   https://bugzilla.redhat.com/show_bug.cgi?id=1505652
>
> To manage notifications about this bug go to:
> https://bugs.launchpad.net/qemu/+bug/1726733/+subscriptions
>
>
>
> ------------------------------
>
> Message: 7
> Date: Fri, 9 Mar 2018 16:01:19 -0600
> From: Eric Blake <eblake@redhat.com>
> To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
> Cc: mreitz@redhat.com, den@openvz.org, jcody@redhat.com,
>         qemu-devel@nongnu.org
> Subject: Re: [Qemu-devel] [PATCH 4/7] qed: Support .bdrv_co_create
> Message-ID: <165fd85f-3131-3ffc-d72f-c88afd43a098@redhat.com>
> Content-Type: text/plain; charset=utf-8; format=flowed
>
> On 03/09/2018 03:46 PM, Kevin Wolf wrote:
> > This adds the .bdrv_co_create driver callback to qed, which
> > enables image creation over QMP.
> >
> > Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> > ---
> >   qapi/block-core.json |  25 ++++++-
> >   block/qed.c          | 204 ++++++++++++++++++++++++++++++
> ++++-----------------
> >   2 files changed, 162 insertions(+), 67 deletions(-)
>
> Similar question as to qcow (who still creates qed images these days?
> and if no one seriously does it outside of our testsuite, would it be
> better to not allow QMP creation of qed images?).  On the other hand,
> qed is newer than qcow so it doesn't have quite the legacy of poor
> usage, so it may also mean that qed gets a longer deprecation cycle than
> qcow.
>
> --
> Eric Blake, Principal Software Engineer
> Red Hat, Inc.           +1-919-301-3266
> Virtualization:  qemu.org | libvirt.org
>
>
>
> ------------------------------
>
> Message: 8
> Date: Fri, 9 Mar 2018 23:07:19 +0100
> From: Thomas Huth <thuth@redhat.com>
> To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org,      Jason Wang
>         <jasowang@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
> Subject: Re: [Qemu-devel] [PATCH] qemu-doc: Rework the network options
>         chapter to make "-net" less prominent
> Message-ID: <66bcb7ee-6d29-330e-328e-b0862c154a43@redhat.com>
> Content-Type: text/plain; charset=utf-8
>
> On 09.03.2018 20:00, Eric Blake wrote:
> > On 03/09/2018 11:41 AM, Thomas Huth wrote:
> >> On 09.03.2018 15:36, Eric Blake wrote:
> >>> On 03/09/2018 12:13 AM, Thomas Huth wrote:
> >>>> "-net" is clearly a legacy option. Yet we still use it in almost all
> >>>> examples in the qemu documentation, and many other spots in the
> network
> >>>> chapter. We should make it less prominent that users are not lured
> into
> >>>> using it so often anymore. So instead of starting the network chapter
> >>>> with
> >>>> "-net nic" and documenting "-net <backend>" below "-netdev <backend>"
> >>>> everywhere, all the "-net" related documentation is now moved to the
> >>>> end
> >>>> of the chapter. The new "--nic" option is moved to the beginning of
> the
> >>>> chapter instead, with a new example that should demonstrate how
> "--nic"
> >>>> can be used to shortcut "--device" with "--netdev".
> >>>> And the examples in this chapter are changed to use the "--device" and
> >>>> "--netdev" options or "--nic" instead of "-net nic -net <backend>".
> >>>>
> >
> >>>> +@example
> >>>> +qemu-system-i386 --netdev user,id=n1,ipv6=off
> >>>> --device=e1000,netdev=n1,mac=52:54:98:76:54:32
> >>>> +qemu-system-i386 --nic user,ipv6=off,model=e1000,mac=
> 52:54:98:76:54:32
> >>>> +@end example
> >>>
> >>> Nice example.
> >>
> >> ... but looks like I even got it wrong - it should be "--device e1000",
> >> without "=". Will fix it.
> >
> > Really?? As I understand it, both long-opt spellings work ('--long=opt'
> > as one arg, and '--long' 'opt' as two args).? So the only reason to drop
> > '=' would be consistency with other examples.
>
> $ qemu-system-x86_64 --device=e1000
> qemu-system-x86_64: --device=e1000: invalid option
>
> Does at least not work for me.
>
>  Thomas
>
>
>
> ------------------------------
>
> Message: 9
> Date: Fri, 9 Mar 2018 16:21:32 -0600
> From: Eric Blake <eblake@redhat.com>
> To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
>         qemu-devel@nongnu.org, qemu-block@nongnu.org
> Cc: pbonzini@redhat.com, den@openvz.org
> Subject: Re: [Qemu-devel] [PATCH 4/5] nbd/server: refactor nbd_trip:
>         cmd_read and generic reply
> Message-ID: <f44dfa2c-ce40-70f6-cad4-e2982d2dfc75@redhat.com>
> Content-Type: text/plain; charset=utf-8; format=flowed
>
> On 03/08/2018 12:46 PM, Vladimir Sementsov-Ogievskiy wrote:
> > nbd_trip has difficult logic of sending reply: it tries to use one
> > code path for all replies. It is ok for simple replies, but is not
> > comfortable for structured replies. Also, two types of error (and
> > corresponding message in local_err) - fatal (leading to disconnect)
> > and not-fatal (just to be sent to the client) are difficult to follow.
> >
> > To make things a bit clearer, the following is done:
> >   - split CMD_READ logic to separate function. It is the most difficult
> >     command for now, and it is definitely cramped inside nbd_trip. Also,
> >     it is difficult to follow CMD_READ logic, shared between
> >     "case NBD_CMD_READ" and "if"s under "reply:" label.
>
> Yay - I already admitted when adding sparse read replies that splitting
> the logic was weird.
>
> >   - create separate helper function nbd_send_generic_reply() and use it
> >     both in new nbd_do_cmd_read and for other command in nbd_trip instead
>
> s/command/commands/
>
> >     of common code-path under "reply:" label in nbd_trip. The helper
> >     supports error message, so logic with local_err in nbd_trip is
>
> s/supports/supports an/
>
> >     simplified.
> >
> > Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> > ---
> >   nbd/server.c | 164 ++++++++++++++++++++++++++++++
> ++---------------------------
> >   1 file changed, 88 insertions(+), 76 deletions(-)
>
> Gains a few lines, but I think the end result is more legible.
>
> >
> > diff --git a/nbd/server.c b/nbd/server.c
> > index 97b45a21fa..a2f5f73d52 100644
> > --- a/nbd/server.c
> > +++ b/nbd/server.c
> > @@ -1520,6 +1520,70 @@ static int nbd_co_receive_request(NBDRequestData
> *req, NBDRequest *request,
> >       return 0;
> >   }
> >
> > +/* Send simple reply without a payload or structured error
>
> s/payload or/payload, or a /
>
> > + * @error_msg is ignored if @ret >= 0 */
>
> Maybe mention the return value (0 if connection is still live, -errno on
> failure to communicate to client)
>
> > +static coroutine_fn int nbd_send_generic_reply(NBDClient *client,
> > +                                               uint64_t handle,
> > +                                               int ret,
> > +                                               const char *error_msg,
> > +                                               Error **errp)
> > +{
> > +    if (client->structured_reply && ret < 0) {
> > +        return nbd_co_send_structured_error(client, handle, -ret,
> error_msg,
> > +                                            errp);
> > +    } else {
> > +        return nbd_co_send_simple_reply(client, handle, ret < 0 ? -ret
> : 0,
> > +                                        NULL, 0, errp);
> > +    }
> > +}
> > +
> > +/* Handle NBD_CMD_READ request.
> > + * Return -errno if sending fails. Other errors are reported directly
> to the
> > + * client as an error reply. */
> > +static coroutine_fn int nbd_do_cmd_read(NBDClient *client, NBDRequest
> *request,
> > +                                        uint8_t *data, Error **errp)
> > +{
>
> > +
> >   /* Owns a reference to the NBDClient passed as opaque.  */
> >   static coroutine_fn void nbd_trip(void *opaque)
> >   {
> > @@ -1529,7 +1593,6 @@ static coroutine_fn void nbd_trip(void *opaque)
> >       NBDRequest request = { 0 };    /* GCC thinks it can be used
> uninitialized */
> >       int ret;
> >       int flags;
> > -    int reply_data_len = 0;
> >       Error *local_err = NULL;
> >       char *msg = NULL;
> >
> > @@ -1556,39 +1619,21 @@ static coroutine_fn void nbd_trip(void *opaque)
> >       }
> >
> >       if (ret < 0) {
> > -        goto reply;
> > +        /* It's not a -EIO, so, accordingly to nbd_co_receive_request()
>
> It wasn't -EIO, so according to nbd_co_receive_request()
>
> > +         * semantics, we should return the error to the client. */
> > +        Error *export_err = local_err;
> > +
> > +        local_err = NULL;
> > +        ret = nbd_send_generic_reply(client, request.handle, -EINVAL,
> > +                                     error_get_pretty(export_err),
> &local_err);
> > +        error_free(export_err);
> > +
> > +        goto replied;
> >       }
> >
> >       switch (request.type) {
> >       case NBD_CMD_READ:
>
> > -        reply_data_len = request.len;
> > +        ret = nbd_do_cmd_read(client, &request, req->data, &local_err);
> >
> >           break;
>
> We could also collapse the empty line before break.
>
> >       case NBD_CMD_WRITE:
> > @@ -1598,9 +1643,8 @@ static coroutine_fn void nbd_trip(void *opaque)
> >           }
> >           ret = blk_pwrite(exp->blk, request.from + exp->dev_offset,
> >                            req->data, request.len, flags);
> > -        if (ret < 0) {
> > -            error_setg_errno(&local_err, -ret, "writing to file
> failed");
> > -        }
> > +        ret = nbd_send_generic_reply(client, request.handle, ret,
> > +                                     "writing to file failed",
> &local_err);
>
> I like how this works out.
>
> >
> >           break;
> >       default:
> > -        error_setg(&local_err, "invalid request type (%" PRIu32 ")
> received",
> > -                   request.type);
> > -        ret = -EINVAL;
> > -    }
> > -
> > -reply:
> > -    if (local_err) {
> > -        /* If we get here, local_err was not a fatal error, and should
> be sent
> > -         * to the client. */
> > -        assert(ret < 0);
> > -        msg = g_strdup(error_get_pretty(local_err));
> > -        error_report_err(local_err);
> > -        local_err = NULL;
> > +        msg = g_strdup_printf("invalid request type (%" PRIu32 ")
> received",
> > +                              request.type);
> > +        ret = nbd_send_generic_reply(client, request.handle, -EINVAL,
> msg,
> > +                                     &local_err);
> > +        g_free(msg);
>
> I wonder if nbd_send_generic_reply() would be any easier to use if it
> took varargs and formatted the argument.  But for now, this is okay.
>
> Only comment and grammar tweaks, so
> Reviewed-by: Eric Blake <eblake@redhat.com>
>
> --
> Eric Blake, Principal Software Engineer
> Red Hat, Inc.           +1-919-301-3266
> Virtualization:  qemu.org | libvirt.org
>
>
>
> ------------------------------
>
> Message: 10
> Date: Fri, 9 Mar 2018 16:29:31 -0600
> From: Eric Blake <eblake@redhat.com>
> To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
>         qemu-devel@nongnu.org, qemu-block@nongnu.org
> Cc: pbonzini@redhat.com, den@openvz.org
> Subject: Re: [Qemu-devel] [PATCH 5/5] nbd/server: refactor nbd_trip:
>         split out nbd_handle_request
> Message-ID: <764ddb1e-541a-7b74-65bf-936c12ed5add@redhat.com>
> Content-Type: text/plain; charset=utf-8; format=flowed
>
> On 03/08/2018 12:46 PM, Vladimir Sementsov-Ogievskiy wrote:
> > Split out request handling logic.
> >
> > Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> > ---
> >   nbd/server.c | 129 ++++++++++++++++++++++++++++++
> +----------------------------
> >   1 file changed, 67 insertions(+), 62 deletions(-)
> >
>
> > +
> > +    switch (request->type) {
> > +    case NBD_CMD_READ:
> > +        return nbd_do_cmd_read(client, request, data, errp);
> > +
> > +    case NBD_CMD_WRITE:
> > +        flags = 0;
> > +        if (request->flags & NBD_CMD_FLAG_FUA) {
> > +            flags |= BDRV_REQ_FUA;
> > +        }
> > +        ret = blk_pwrite(exp->blk, request->from + exp->dev_offset,
> > +                         data, request->len, flags);
> > +
> > +        return nbd_send_generic_reply(client, request->handle, ret,
> > +                                      "writing to file failed", errp);
> > +    case NBD_CMD_WRITE_ZEROES:
>
> Inconsistent spacing between return and the next case label.
>
> But switching whitespace is trivial, so
>
> Reviewed-by: Eric Blake <eblake@redhat.com>
>
> --
> Eric Blake, Principal Software Engineer
> Red Hat, Inc.           +1-919-301-3266
> Virtualization:  qemu.org | libvirt.org
>
>
>
> ------------------------------
>
> Message: 11
> Date: Fri, 09 Mar 2018 14:31:01 -0800 (PST)
> From: Palmer Dabbelt <palmer@sifive.com>
> To: cota@braap.org
> Cc: Michael Clark <mjc@sifive.com>, sorear2@gmail.com,
>         peter.maydell@linaro.org,       richard.henderson@linaro.org,
>         qemu-devel@nongnu.org
> Subject: Re: [Qemu-devel] Apparently fpu/softfloat.c:1374 is reachable
> Message-ID: <mhng-7257de0b-ff7e-455a-86e2-4fee6df5c250@palmer-si-x1c4>
> Content-Type: text/plain; charset=utf-8; format=flowed
>
> On Fri, 09 Mar 2018 13:49:57 PST (-0800), cota@braap.org wrote:
> > On Fri, Mar 09, 2018 at 11:34:56 +0000, Michael Clark wrote:
> > Isn't Cc'ing riscv-patches an obvious use case for using the --cc flag?
> > (BTW You can add as many --cc's as you want, and these apply to all
> patches
> > in a series.)
>
> FWIW, that's what I do with my patches.  I generally only add CC lines to
> the
> patches if the address won't be found by the normal means (ie,
> scripts/get_maintainer.pl) -- for example, maybe someone helped out a lot
> with
> the patch but hasn't provided a reviewed-by yet.  Everyone else should
> come out
> of the script, which makes it easy to avoid forgetting :).
>
> Of course, that's all for my Linux stuff.  While I haven't really
> submitted any
> QEMU patches, the flow seems very similar to Linux.  The GNU flow is a bit
> different, but the git-send-email flow is very similar (without
> get_maintainers).
>
>
>
> ------------------------------
>
> Message: 12
> Date: Fri, 9 Mar 2018 16:33:42 -0600
> From: Eric Blake <eblake@redhat.com>
> To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,      Jason Wang
>         <jasowang@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
> Subject: Re: [Qemu-devel] [PATCH] qemu-doc: Rework the network options
>         chapter to make "-net" less prominent
> Message-ID: <338bfeec-aa1f-d8a5-2b02-93d6ce16143b@redhat.com>
> Content-Type: text/plain; charset=utf-8; format=flowed
>
> On 03/09/2018 04:07 PM, Thomas Huth wrote:
>
> >>> ... but looks like I even got it wrong - it should be "--device e1000",
> >>> without "=". Will fix it.
> >>
> >> Really?? As I understand it, both long-opt spellings work ('--long=opt'
> >> as one arg, and '--long' 'opt' as two args).? So the only reason to drop
> >> '=' would be consistency with other examples.
>
> Well, that would be true if we used getopt_long_only().  But we don't
> (we stupidly rolled our own command line parser, meaning it has quirks
> that are different from everything else that uses the standardized parser).
>
> >
> > $ qemu-system-x86_64 --device=e1000
> > qemu-system-x86_64: --device=e1000: invalid option
> >
> > Does at least not work for me.
>
> Maybe our QemuOpts parser should be taught to make it work.  But that's
> orthogonal, so you are right that for now we just always document things
> as the two-arg form, since the one-arg form with '=' isn't implemented.
>
> --
> Eric Blake, Principal Software Engineer
> Red Hat, Inc.           +1-919-301-3266
> Virtualization:  qemu.org | libvirt.org
>
>
>
> ------------------------------
>
> Message: 13
> Date: Sat, 10 Mar 2018 00:42:54 +0200
> From: "Michael S. Tsirkin" <mst@redhat.com>
> To: Jason Baron <jbaron@akamai.com>
> Cc: qemu-devel@nongnu.org, jasowang@redhat.com,
>         virtio-dev@lists.oasis-open.org
> Subject: Re: [Qemu-devel] [PATCH v2 1/3] scripts/update-linux-headers:
>         add ethtool.h and update to 4.16.0-rc4
> Message-ID: <20180310004217-mutt-send-email-mst@kernel.org>
> Content-Type: text/plain; charset=us-ascii
>
> On Wed, Mar 07, 2018 at 10:25:39PM -0500, Jason Baron wrote:
> > A subsequent patch to add support for setting linkspeed/duplex in
> > virtio-net, requires a few definitions from ethtool.h, which ends up
> > pulling in kernel.h and sysinfo.h as well.
> >
> > Signed-off-by: Jason Baron <jbaron@akamai.com>
> > Cc: "Michael S. Tsirkin" <mst@redhat.com>
> > Cc: Jason Wang <jasowang@redhat.com>
> > Cc: virtio-dev@lists.oasis-open.org
>
> I will drop unrelated stuff and just update files we need.
>
> > ---
> >  include/standard-headers/linux/ethtool.h | 1821
> ++++++++++++++++++++++++++++++
> >  include/standard-headers/linux/input.h   |    4 +-
> >  include/standard-headers/linux/kernel.h  |   15 +
> >  include/standard-headers/linux/sysinfo.h |   25 +
> >  linux-headers/asm-x86/kvm_para.h         |    1 +
> >  linux-headers/linux/kvm.h                |    2 +
> >  scripts/update-linux-headers.sh          |   11 +-
> >  7 files changed, 1876 insertions(+), 3 deletions(-)
> >  create mode 100644 include/standard-headers/linux/ethtool.h
> >  create mode 100644 include/standard-headers/linux/kernel.h
> >  create mode 100644 include/standard-headers/linux/sysinfo.h
> >
> > diff --git a/include/standard-headers/linux/ethtool.h
> b/include/standard-headers/linux/ethtool.h
> > new file mode 100644
> > index 0000000..94aacb7
> > --- /dev/null
> > +++ b/include/standard-headers/linux/ethtool.h
> > @@ -0,0 +1,1821 @@
> > +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> > +/*
> > + * ethtool.h: Defines for Linux ethtool.
> > + *
> > + * Copyright (C) 1998 David S. Miller (davem@redhat.com)
> > + * Copyright 2001 Jeff Garzik <jgarzik@pobox.com>
> > + * Portions Copyright 2001 Sun Microsystems (thockin@sun.com)
> > + * Portions Copyright 2002 Intel (eli.kupermann@intel.com,
> > + *                                christopher.leech@intel.com,
> > + *                                scott.feldman@intel.com)
> > + * Portions Copyright (C) Sun Microsystems 2008
> > + */
> > +
> > +#ifndef _LINUX_ETHTOOL_H
> > +#define _LINUX_ETHTOOL_H
> > +
> > +#include "net/eth.h"
> > +
> > +#include "standard-headers/linux/kernel.h"
> > +#include "standard-headers/linux/types.h"
> > +#include "standard-headers/linux/if_ether.h"
> > +
> > +#include <limits.h> /* for INT_MAX */
> > +
> > +/* All structures exposed to userland should be defined such that they
> > + * have the same layout for 32-bit and 64-bit userland.
> > + */
> > +
> > +/**
> > + * struct ethtool_cmd - DEPRECATED, link control and status
> > + * This structure is DEPRECATED, please use struct
> ethtool_link_settings.
> > + * @cmd: Command number = %ETHTOOL_GSET or %ETHTOOL_SSET
> > + * @supported: Bitmask of %SUPPORTED_* flags for the link modes,
> > + *   physical connectors and other link features for which the
> > + *   interface supports autonegotiation or auto-detection.
> > + *   Read-only.
> > + * @advertising: Bitmask of %ADVERTISED_* flags for the link modes,
> > + *   physical connectors and other link features that are
> > + *   advertised through autonegotiation or enabled for
> > + *   auto-detection.
> > + * @speed: Low bits of the speed, 1Mb units, 0 to INT_MAX or
> SPEED_UNKNOWN
> > + * @duplex: Duplex mode; one of %DUPLEX_*
> > + * @port: Physical connector type; one of %PORT_*
> > + * @phy_address: MDIO address of PHY (transceiver); 0 or 255 if not
> > + *   applicable.  For clause 45 PHYs this is the PRTAD.
> > + * @transceiver: Historically used to distinguish different possible
> > + *   PHY types, but not in a consistent way.  Deprecated.
> > + * @autoneg: Enable/disable autonegotiation and auto-detection;
> > + *   either %AUTONEG_DISABLE or %AUTONEG_ENABLE
> > + * @mdio_support: Bitmask of %ETH_MDIO_SUPPORTS_* flags for the MDIO
> > + *   protocols supported by the interface; 0 if unknown.
> > + *   Read-only.
> > + * @maxtxpkt: Historically used to report TX IRQ coalescing; now
> > + *   obsoleted by &struct ethtool_coalesce.  Read-only; deprecated.
> > + * @maxrxpkt: Historically used to report RX IRQ coalescing; now
> > + *   obsoleted by &struct ethtool_coalesce.  Read-only; deprecated.
> > + * @speed_hi: High bits of the speed, 1Mb units, 0 to INT_MAX or
> SPEED_UNKNOWN
> > + * @eth_tp_mdix: Ethernet twisted-pair MDI(-X) status; one of
> > + *   %ETH_TP_MDI_*.  If the status is unknown or not applicable, the
> > + *   value will be %ETH_TP_MDI_INVALID.  Read-only.
> > + * @eth_tp_mdix_ctrl: Ethernet twisted pair MDI(-X) control; one of
> > + *   %ETH_TP_MDI_*.  If MDI(-X) control is not implemented, reads
> > + *   yield %ETH_TP_MDI_INVALID and writes may be ignored or rejected.
> > + *   When written successfully, the link should be renegotiated if
> > + *   necessary.
> > + * @lp_advertising: Bitmask of %ADVERTISED_* flags for the link modes
> > + *   and other link features that the link partner advertised
> > + *   through autonegotiation; 0 if unknown or not applicable.
> > + *   Read-only.
> > + *
> > + * The link speed in Mbps is split between @speed and @speed_hi.  Use
> > + * the ethtool_cmd_speed() and ethtool_cmd_speed_set() functions to
> > + * access it.
> > + *
> > + * If autonegotiation is disabled, the speed and @duplex represent the
> > + * fixed link mode and are writable if the driver supports multiple
> > + * link modes.  If it is enabled then they are read-only; if the link
> > + * is up they represent the negotiated link mode; if the link is down,
> > + * the speed is 0, %SPEED_UNKNOWN or the highest enabled speed and
> > + * @duplex is %DUPLEX_UNKNOWN or the best enabled duplex mode.
> > + *
> > + * Some hardware interfaces may have multiple PHYs and/or physical
> > + * connectors fitted or do not allow the driver to detect which are
> > + * fitted.  For these interfaces @port and/or @phy_address may be
> > + * writable, possibly dependent on @autoneg being %AUTONEG_DISABLE.
> > + * Otherwise, attempts to write different values may be ignored or
> > + * rejected.
> > + *
> > + * Users should assume that all fields not marked read-only are
> > + * writable and subject to validation by the driver.  They should use
> > + * %ETHTOOL_GSET to get the current values before making specific
> > + * changes and then applying them with %ETHTOOL_SSET.
> > + *
> > + * Drivers that implement set_settings() should validate all fields
> > + * other than @cmd that are not described as read-only or deprecated,
> > + * and must ignore all fields described as read-only.
> > + *
> > + * Deprecated fields should be ignored by both users and drivers.
> > + */
> > +struct ethtool_cmd {
> > +     uint32_t        cmd;
> > +     uint32_t        supported;
> > +     uint32_t        advertising;
> > +     uint16_t        speed;
> > +     uint8_t duplex;
> > +     uint8_t port;
> > +     uint8_t phy_address;
> > +     uint8_t transceiver;
> > +     uint8_t autoneg;
> > +     uint8_t mdio_support;
> > +     uint32_t        maxtxpkt;
> > +     uint32_t        maxrxpkt;
> > +     uint16_t        speed_hi;
> > +     uint8_t eth_tp_mdix;
> > +     uint8_t eth_tp_mdix_ctrl;
> > +     uint32_t        lp_advertising;
> > +     uint32_t        reserved[2];
> > +};
> > +
> > +static inline void ethtool_cmd_speed_set(struct ethtool_cmd *ep,
> > +                                      uint32_t speed)
> > +{
> > +     ep->speed = (uint16_t)(speed & 0xFFFF);
> > +     ep->speed_hi = (uint16_t)(speed >> 16);
> > +}
> > +
> > +static inline uint32_t ethtool_cmd_speed(const struct ethtool_cmd *ep)
> > +{
> > +     return (ep->speed_hi << 16) | ep->speed;
> > +}
> > +
> > +/* Device supports clause 22 register access to PHY or peripherals
> > + * using the interface defined in "standard-headers/linux/mii.h".
> This should not be
> > + * set if there are known to be no such peripherals present or if
> > + * the driver only emulates clause 22 registers for compatibility.
> > + */
> > +#define ETH_MDIO_SUPPORTS_C22        1
> > +
> > +/* Device supports clause 45 register access to PHY or peripherals
> > + * using the interface defined in "standard-headers/linux/mii.h" and
> <linux/mdio.h>.
> > + * This should not be set if there are known to be no such peripherals
> > + * present.
> > + */
> > +#define ETH_MDIO_SUPPORTS_C45        2
> > +
> > +#define ETHTOOL_FWVERS_LEN   32
> > +#define ETHTOOL_BUSINFO_LEN  32
> > +#define ETHTOOL_EROMVERS_LEN 32
> > +
> > +/**
> > + * struct ethtool_drvinfo - general driver and device information
> > + * @cmd: Command number = %ETHTOOL_GDRVINFO
> > + * @driver: Driver short name.  This should normally match the name
> > + *   in its bus driver structure (e.g. pci_driver::name).  Must
> > + *   not be an empty string.
> > + * @version: Driver version string; may be an empty string
> > + * @fw_version: Firmware version string; may be an empty string
> > + * @erom_version: Expansion ROM version string; may be an empty string
> > + * @bus_info: Device bus address.  This should match the dev_name()
> > + *   string for the underlying bus device, if there is one.  May be
> > + *   an empty string.
> > + * @n_priv_flags: Number of flags valid for %ETHTOOL_GPFLAGS and
> > + *   %ETHTOOL_SPFLAGS commands; also the number of strings in the
> > + *   %ETH_SS_PRIV_FLAGS set
> > + * @n_stats: Number of uint64_t statistics returned by the
> %ETHTOOL_GSTATS
> > + *   command; also the number of strings in the %ETH_SS_STATS set
> > + * @testinfo_len: Number of results returned by the %ETHTOOL_TEST
> > + *   command; also the number of strings in the %ETH_SS_TEST set
> > + * @eedump_len: Size of EEPROM accessible through the %ETHTOOL_GEEPROM
> > + *   and %ETHTOOL_SEEPROM commands, in bytes
> > + * @regdump_len: Size of register dump returned by the %ETHTOOL_GREGS
> > + *   command, in bytes
> > + *
> > + * Users can use the %ETHTOOL_GSSET_INFO command to get the number of
> > + * strings in any string set (from Linux 2.6.34).
> > + *
> > + * Drivers should set at most @driver, @version, @fw_version and
> > + * @bus_info in their get_drvinfo() implementation.  The ethtool
> > + * core fills in the other fields using other driver operations.
> > + */
> > +struct ethtool_drvinfo {
> > +     uint32_t        cmd;
> > +     char    driver[32];
> > +     char    version[32];
> > +     char    fw_version[ETHTOOL_FWVERS_LEN];
> > +     char    bus_info[ETHTOOL_BUSINFO_LEN];
> > +     char    erom_version[ETHTOOL_EROMVERS_LEN];
> > +     char    reserved2[12];
> > +     uint32_t        n_priv_flags;
> > +     uint32_t        n_stats;
> > +     uint32_t        testinfo_len;
> > +     uint32_t        eedump_len;
> > +     uint32_t        regdump_len;
> > +};
> > +
> > +#define SOPASS_MAX   6
> > +
> > +/**
> > + * struct ethtool_wolinfo - Wake-On-Lan configuration
> > + * @cmd: Command number = %ETHTOOL_GWOL or %ETHTOOL_SWOL
> > + * @supported: Bitmask of %WAKE_* flags for supported Wake-On-Lan modes.
> > + *   Read-only.
> > + * @wolopts: Bitmask of %WAKE_* flags for enabled Wake-On-Lan modes.
> > + * @sopass: SecureOn(tm) password; meaningful only if %WAKE_MAGICSECURE
> > + *   is set in @wolopts.
> > + */
> > +struct ethtool_wolinfo {
> > +     uint32_t        cmd;
> > +     uint32_t        supported;
> > +     uint32_t        wolopts;
> > +     uint8_t sopass[SOPASS_MAX];
> > +};
> > +
> > +/* for passing single values */
> > +struct ethtool_value {
> > +     uint32_t        cmd;
> > +     uint32_t        data;
> > +};
> > +
> > +enum tunable_id {
> > +     ETHTOOL_ID_UNSPEC,
> > +     ETHTOOL_RX_COPYBREAK,
> > +     ETHTOOL_TX_COPYBREAK,
> > +     /*
> > +      * Add your fresh new tubale attribute above and remember to update
> > +      * tunable_strings[] in net/core/ethtool.c
> > +      */
> > +     __ETHTOOL_TUNABLE_COUNT,
> > +};
> > +
> > +enum tunable_type_id {
> > +     ETHTOOL_TUNABLE_UNSPEC,
> > +     ETHTOOL_TUNABLE_U8,
> > +     ETHTOOL_TUNABLE_U16,
> > +     ETHTOOL_TUNABLE_U32,
> > +     ETHTOOL_TUNABLE_U64,
> > +     ETHTOOL_TUNABLE_STRING,
> > +     ETHTOOL_TUNABLE_S8,
> > +     ETHTOOL_TUNABLE_S16,
> > +     ETHTOOL_TUNABLE_S32,
> > +     ETHTOOL_TUNABLE_S64,
> > +};
> > +
> > +struct ethtool_tunable {
> > +     uint32_t        cmd;
> > +     uint32_t        id;
> > +     uint32_t        type_id;
> > +     uint32_t        len;
> > +     void    *data[0];
> > +};
> > +
> > +#define DOWNSHIFT_DEV_DEFAULT_COUNT  0xff
> > +#define DOWNSHIFT_DEV_DISABLE                0
> > +
> > +enum phy_tunable_id {
> > +     ETHTOOL_PHY_ID_UNSPEC,
> > +     ETHTOOL_PHY_DOWNSHIFT,
> > +     /*
> > +      * Add your fresh new phy tunable attribute above and remember to
> update
> > +      * phy_tunable_strings[] in net/core/ethtool.c
> > +      */
> > +     __ETHTOOL_PHY_TUNABLE_COUNT,
> > +};
> > +
> > +/**
> > + * struct ethtool_regs - hardware register dump
> > + * @cmd: Command number = %ETHTOOL_GREGS
> > + * @version: Dump format version.  This is driver-specific and may
> > + *   distinguish different chips/revisions.  Drivers must use new
> > + *   version numbers whenever the dump format changes in an
> > + *   incompatible way.
> > + * @len: On entry, the real length of @data.  On return, the number of
> > + *   bytes used.
> > + * @data: Buffer for the register dump
> > + *
> > + * Users should use %ETHTOOL_GDRVINFO to find the maximum length of
> > + * a register dump for the interface.  They must allocate the buffer
> > + * immediately following this structure.
> > + */
> > +struct ethtool_regs {
> > +     uint32_t        cmd;
> > +     uint32_t        version;
> > +     uint32_t        len;
> > +     uint8_t data[0];
> > +};
> > +
> > +/**
> > + * struct ethtool_eeprom - EEPROM dump
> > + * @cmd: Command number = %ETHTOOL_GEEPROM, %ETHTOOL_GMODULEEEPROM or
> > + *   %ETHTOOL_SEEPROM
> > + * @magic: A 'magic cookie' value to guard against accidental changes.
> > + *   The value passed in to %ETHTOOL_SEEPROM must match the value
> > + *   returned by %ETHTOOL_GEEPROM for the same device.  This is
> > + *   unused when @cmd is %ETHTOOL_GMODULEEEPROM.
> > + * @offset: Offset within the EEPROM to begin reading/writing, in bytes
> > + * @len: On entry, number of bytes to read/write.  On successful
> > + *   return, number of bytes actually read/written.  In case of
> > + *   error, this may indicate at what point the error occurred.
> > + * @data: Buffer to read/write from
> > + *
> > + * Users may use %ETHTOOL_GDRVINFO or %ETHTOOL_GMODULEINFO to find
> > + * the length of an on-board or module EEPROM, respectively.  They
> > + * must allocate the buffer immediately following this structure.
> > + */
> > +struct ethtool_eeprom {
> > +     uint32_t        cmd;
> > +     uint32_t        magic;
> > +     uint32_t        offset;
> > +     uint32_t        len;
> > +     uint8_t data[0];
> > +};
> > +
> > +/**
> > + * struct ethtool_eee - Energy Efficient Ethernet information
> > + * @cmd: ETHTOOL_{G,S}EEE
> > + * @supported: Mask of %SUPPORTED_* flags for the speed/duplex
> combinations
> > + *   for which there is EEE support.
> > + * @advertised: Mask of %ADVERTISED_* flags for the speed/duplex
> combinations
> > + *   advertised as eee capable.
> > + * @lp_advertised: Mask of %ADVERTISED_* flags for the speed/duplex
> > + *   combinations advertised by the link partner as eee capable.
> > + * @eee_active: Result of the eee auto negotiation.
> > + * @eee_enabled: EEE configured mode (enabled/disabled).
> > + * @tx_lpi_enabled: Whether the interface should assert its tx lpi,
> given
> > + *   that eee was negotiated.
> > + * @tx_lpi_timer: Time in microseconds the interface delays prior to
> asserting
> > + *   its tx lpi (after reaching 'idle' state). Effective only when eee
> > + *   was negotiated and tx_lpi_enabled was set.
> > + */
> > +struct ethtool_eee {
> > +     uint32_t        cmd;
> > +     uint32_t        supported;
> > +     uint32_t        advertised;
> > +     uint32_t        lp_advertised;
> > +     uint32_t        eee_active;
> > +     uint32_t        eee_enabled;
> > +     uint32_t        tx_lpi_enabled;
> > +     uint32_t        tx_lpi_timer;
> > +     uint32_t        reserved[2];
> > +};
> > +
> > +/**
> > + * struct ethtool_modinfo - plugin module eeprom information
> > + * @cmd: %ETHTOOL_GMODULEINFO
> > + * @type: Standard the module information conforms to
> %ETH_MODULE_SFF_xxxx
> > + * @eeprom_len: Length of the eeprom
> > + *
> > + * This structure is used to return the information to
> > + * properly size memory for a subsequent call to %ETHTOOL_GMODULEEEPROM.
> > + * The type code indicates the eeprom data format
> > + */
> > +struct ethtool_modinfo {
> > +     uint32_t   cmd;
> > +     uint32_t   type;
> > +     uint32_t   eeprom_len;
> > +     uint32_t   reserved[8];
> > +};
> > +
> > +/**
> > + * struct ethtool_coalesce - coalescing parameters for IRQs and stats
> updates
> > + * @cmd: ETHTOOL_{G,S}COALESCE
> > + * @rx_coalesce_usecs: How many usecs to delay an RX interrupt after
> > + *   a packet arrives.
> > + * @rx_max_coalesced_frames: Maximum number of packets to receive
> > + *   before an RX interrupt.
> > + * @rx_coalesce_usecs_irq: Same as @rx_coalesce_usecs, except that
> > + *   this value applies while an IRQ is being serviced by the host.
> > + * @rx_max_coalesced_frames_irq: Same as @rx_max_coalesced_frames,
> > + *   except that this value applies while an IRQ is being serviced
> > + *   by the host.
> > + * @tx_coalesce_usecs: How many usecs to delay a TX interrupt after
> > + *   a packet is sent.
> > + * @tx_max_coalesced_frames: Maximum number of packets to be sent
> > + *   before a TX interrupt.
> > + * @tx_coalesce_usecs_irq: Same as @tx_coalesce_usecs, except that
> > + *   this value applies while an IRQ is being serviced by the host.
> > + * @tx_max_coalesced_frames_irq: Same as @tx_max_coalesced_frames,
> > + *   except that this value applies while an IRQ is being serviced
> > + *   by the host.
> > + * @stats_block_coalesce_usecs: How many usecs to delay in-memory
> > + *   statistics block updates.  Some drivers do not have an
> > + *   in-memory statistic block, and in such cases this value is
> > + *   ignored.  This value must not be zero.
> > + * @use_adaptive_rx_coalesce: Enable adaptive RX coalescing.
> > + * @use_adaptive_tx_coalesce: Enable adaptive TX coalescing.
> > + * @pkt_rate_low: Threshold for low packet rate (packets per second).
> > + * @rx_coalesce_usecs_low: How many usecs to delay an RX interrupt after
> > + *   a packet arrives, when the packet rate is below @pkt_rate_low.
> > + * @rx_max_coalesced_frames_low: Maximum number of packets to be
> received
> > + *   before an RX interrupt, when the packet rate is below
> @pkt_rate_low.
> > + * @tx_coalesce_usecs_low: How many usecs to delay a TX interrupt after
> > + *   a packet is sent, when the packet rate is below @pkt_rate_low.
> > + * @tx_max_coalesced_frames_low: Maximum nuumber of packets to be sent
> before
> > + *   a TX interrupt, when the packet rate is below @pkt_rate_low.
> > + * @pkt_rate_high: Threshold for high packet rate (packets per second).
> > + * @rx_coalesce_usecs_high: How many usecs to delay an RX interrupt
> after
> > + *   a packet arrives, when the packet rate is above @pkt_rate_high.
> > + * @rx_max_coalesced_frames_high: Maximum number of packets to be
> received
> > + *   before an RX interrupt, when the packet rate is above
> @pkt_rate_high.
> > + * @tx_coalesce_usecs_high: How many usecs to delay a TX interrupt after
> > + *   a packet is sent, when the packet rate is above @pkt_rate_high.
> > + * @tx_max_coalesced_frames_high: Maximum number of packets to be sent
> before
> > + *   a TX interrupt, when the packet rate is above @pkt_rate_high.
> > + * @rate_sample_interval: How often to do adaptive coalescing packet
> rate
> > + *   sampling, measured in seconds.  Must not be zero.
> > + *
> > + * Each pair of (usecs, max_frames) fields specifies that interrupts
> > + * should be coalesced until
> > + *   (usecs > 0 && time_since_first_completion >= usecs) ||
> > + *   (max_frames > 0 && completed_frames >= max_frames)
> > + *
> > + * It is illegal to set both usecs and max_frames to zero as this
> > + * would cause interrupts to never be generated.  To disable
> > + * coalescing, set usecs = 0 and max_frames = 1.
> > + *
> > + * Some implementations ignore the value of max_frames and use the
> > + * condition time_since_first_completion >= usecs
> > + *
> > + * This is deprecated.  Drivers for hardware that does not support
> > + * counting completions should validate that max_frames == !rx_usecs.
> > + *
> > + * Adaptive RX/TX coalescing is an algorithm implemented by some
> > + * drivers to improve latency under low packet rates and improve
> > + * throughput under high packet rates.  Some drivers only implement
> > + * one of RX or TX adaptive coalescing.  Anything not implemented by
> > + * the driver causes these values to be silently ignored.
> > + *
> > + * When the packet rate is below @pkt_rate_high but above
> > + * @pkt_rate_low (both measured in packets per second) the
> > + * normal {rx,tx}_* coalescing parameters are used.
> > + */
> > +struct ethtool_coalesce {
> > +     uint32_t        cmd;
> > +     uint32_t        rx_coalesce_usecs;
> > +     uint32_t        rx_max_coalesced_frames;
> > +     uint32_t        rx_coalesce_usecs_irq;
> > +     uint32_t        rx_max_coalesced_frames_irq;
> > +     uint32_t        tx_coalesce_usecs;
> > +     uint32_t        tx_max_coalesced_frames;
> > +     uint32_t        tx_coalesce_usecs_irq;
> > +     uint32_t        tx_max_coalesced_frames_irq;
> > +     uint32_t        stats_block_coalesce_usecs;
> > +     uint32_t        use_adaptive_rx_coalesce;
> > +     uint32_t        use_adaptive_tx_coalesce;
> > +     uint32_t        pkt_rate_low;
> > +     uint32_t        rx_coalesce_usecs_low;
> > +     uint32_t        rx_max_coalesced_frames_low;
> > +     uint32_t        tx_coalesce_usecs_low;
> > +     uint32_t        tx_max_coalesced_frames_low;
> > +     uint32_t        pkt_rate_high;
> > +     uint32_t        rx_coalesce_usecs_high;
> > +     uint32_t        rx_max_coalesced_frames_high;
> > +     uint32_t        tx_coalesce_usecs_high;
> > +     uint32_t        tx_max_coalesced_frames_high;
> > +     uint32_t        rate_sample_interval;
> > +};
> > +
> > +/**
> > + * struct ethtool_ringparam - RX/TX ring parameters
> > + * @cmd: Command number = %ETHTOOL_GRINGPARAM or %ETHTOOL_SRINGPARAM
> > + * @rx_max_pending: Maximum supported number of pending entries per
> > + *   RX ring.  Read-only.
> > + * @rx_mini_max_pending: Maximum supported number of pending entries
> > + *   per RX mini ring.  Read-only.
> > + * @rx_jumbo_max_pending: Maximum supported number of pending entries
> > + *   per RX jumbo ring.  Read-only.
> > + * @tx_max_pending: Maximum supported number of pending entries per
> > + *   TX ring.  Read-only.
> > + * @rx_pending: Current maximum number of pending entries per RX ring
> > + * @rx_mini_pending: Current maximum number of pending entries per RX
> > + *   mini ring
> > + * @rx_jumbo_pending: Current maximum number of pending entries per RX
> > + *   jumbo ring
> > + * @tx_pending: Current maximum supported number of pending entries
> > + *   per TX ring
> > + *
> > + * If the interface does not have separate RX mini and/or jumbo rings,
> > + * @rx_mini_max_pending and/or @rx_jumbo_max_pending will be 0.
> > + *
> > + * There may also be driver-dependent minimum values for the number
> > + * of entries per ring.
> > + */
> > +struct ethtool_ringparam {
> > +     uint32_t        cmd;
> > +     uint32_t        rx_max_pending;
> > +     uint32_t        rx_mini_max_pending;
> > +     uint32_t        rx_jumbo_max_pending;
> > +     uint32_t        tx_max_pending;
> > +     uint32_t        rx_pending;
> > +     uint32_t        rx_mini_pending;
> > +     uint32_t        rx_jumbo_pending;
> > +     uint32_t        tx_pending;
> > +};
> > +
> > +/**
> > + * struct ethtool_channels - configuring number of network channel
> > + * @cmd: ETHTOOL_{G,S}CHANNELS
> > + * @max_rx: Read only. Maximum number of receive channel the driver
> support.
> > + * @max_tx: Read only. Maximum number of transmit channel the driver
> support.
> > + * @max_other: Read only. Maximum number of other channel the driver
> support.
> > + * @max_combined: Read only. Maximum number of combined channel the
> driver
> > + *   support. Set of queues RX, TX or other.
> > + * @rx_count: Valid values are in the range 1 to the max_rx.
> > + * @tx_count: Valid values are in the range 1 to the max_tx.
> > + * @other_count: Valid values are in the range 1 to the max_other.
> > + * @combined_count: Valid values are in the range 1 to the max_combined.
> > + *
> > + * This can be used to configure RX, TX and other channels.
> > + */
> > +
> > +struct ethtool_channels {
> > +     uint32_t        cmd;
> > +     uint32_t        max_rx;
> > +     uint32_t        max_tx;
> > +     uint32_t        max_other;
> > +     uint32_t        max_combined;
> > +     uint32_t        rx_count;
> > +     uint32_t        tx_count;
> > +     uint32_t        other_count;
> > +     uint32_t        combined_count;
> > +};
> > +
> > +/**
> > + * struct ethtool_pauseparam - Ethernet pause (flow control) parameters
> > + * @cmd: Command number = %ETHTOOL_GPAUSEPARAM or %ETHTOOL_SPAUSEPARAM
> > + * @autoneg: Flag to enable autonegotiation of pause frame use
> > + * @rx_pause: Flag to enable reception of pause frames
> > + * @tx_pause: Flag to enable transmission of pause frames
> > + *
> > + * Drivers should reject a non-zero setting of @autoneg when
> > + * autoneogotiation is disabled (or not supported) for the link.
> > + *
> > + * If the link is autonegotiated, drivers should use
> > + * mii_advertise_flowctrl() or similar code to set the advertised
> > + * pause frame capabilities based on the @rx_pause and @tx_pause flags,
> > + * even if @autoneg is zero.  They should also allow the advertised
> > + * pause frame capabilities to be controlled directly through the
> > + * advertising field of &struct ethtool_cmd.
> > + *
> > + * If @autoneg is non-zero, the MAC is configured to send and/or
> > + * receive pause frames according to the result of autonegotiation.
> > + * Otherwise, it is configured directly based on the @rx_pause and
> > + * @tx_pause flags.
> > + */
> > +struct ethtool_pauseparam {
> > +     uint32_t        cmd;
> > +     uint32_t        autoneg;
> > +     uint32_t        rx_pause;
> > +     uint32_t        tx_pause;
> > +};
> > +
> > +#define ETH_GSTRING_LEN              32
> > +
> > +/**
> > + * enum ethtool_stringset - string set ID
> > + * @ETH_SS_TEST: Self-test result names, for use with %ETHTOOL_TEST
> > + * @ETH_SS_STATS: Statistic names, for use with %ETHTOOL_GSTATS
> > + * @ETH_SS_PRIV_FLAGS: Driver private flag names, for use with
> > + *   %ETHTOOL_GPFLAGS and %ETHTOOL_SPFLAGS
> > + * @ETH_SS_NTUPLE_FILTERS: Previously used with %ETHTOOL_GRXNTUPLE;
> > + *   now deprecated
> > + * @ETH_SS_FEATURES: Device feature names
> > + * @ETH_SS_RSS_HASH_FUNCS: RSS hush function names
> > + * @ETH_SS_PHY_STATS: Statistic names, for use with %ETHTOOL_GPHYSTATS
> > + * @ETH_SS_PHY_TUNABLES: PHY tunable names
> > + */
> > +enum ethtool_stringset {
> > +     ETH_SS_TEST             = 0,
> > +     ETH_SS_STATS,
> > +     ETH_SS_PRIV_FLAGS,
> > +     ETH_SS_NTUPLE_FILTERS,
> > +     ETH_SS_FEATURES,
> > +     ETH_SS_RSS_HASH_FUNCS,
> > +     ETH_SS_TUNABLES,
> > +     ETH_SS_PHY_STATS,
> > +     ETH_SS_PHY_TUNABLES,
> > +};
> > +
> > +/**
> > + * struct ethtool_gstrings - string set for data tagging
> > + * @cmd: Command number = %ETHTOOL_GSTRINGS
> > + * @string_set: String set ID; one of &enum ethtool_stringset
> > + * @len: On return, the number of strings in the string set
> > + * @data: Buffer for strings.  Each string is null-padded to a size of
> > + *   %ETH_GSTRING_LEN.
> > + *
> > + * Users must use %ETHTOOL_GSSET_INFO to find the number of strings in
> > + * the string set.  They must allocate a buffer of the appropriate
> > + * size immediately following this structure.
> > + */
> > +struct ethtool_gstrings {
> > +     uint32_t        cmd;
> > +     uint32_t        string_set;
> > +     uint32_t        len;
> > +     uint8_t data[0];
> > +};
> > +
> > +/**
> > + * struct ethtool_sset_info - string set information
> > + * @cmd: Command number = %ETHTOOL_GSSET_INFO
> > + * @sset_mask: On entry, a bitmask of string sets to query, with bits
> > + *   numbered according to &enum ethtool_stringset.  On return, a
> > + *   bitmask of those string sets queried that are supported.
> > + * @data: Buffer for string set sizes.  On return, this contains the
> > + *   size of each string set that was queried and supported, in
> > + *   order of ID.
> > + *
> > + * Example: The user passes in @sset_mask = 0x7 (sets 0, 1, 2) and on
> > + * return @sset_mask == 0x6 (sets 1, 2).  Then @data[0] contains the
> > + * size of set 1 and @data[1] contains the size of set 2.
> > + *
> > + * Users must allocate a buffer of the appropriate size (4 * number of
> > + * sets queried) immediately following this structure.
> > + */
> > +struct ethtool_sset_info {
> > +     uint32_t        cmd;
> > +     uint32_t        reserved;
> > +     uint64_t        sset_mask;
> > +     uint32_t        data[0];
> > +};
> > +
> > +/**
> > + * enum ethtool_test_flags - flags definition of ethtool_test
> > + * @ETH_TEST_FL_OFFLINE: if set perform online and offline tests,
> otherwise
> > + *   only online tests.
> > + * @ETH_TEST_FL_FAILED: Driver set this flag if test fails.
> > + * @ETH_TEST_FL_EXTERNAL_LB: Application request to perform external
> loopback
> > + *   test.
> > + * @ETH_TEST_FL_EXTERNAL_LB_DONE: Driver performed the external
> loopback test
> > + */
> > +
> > +enum ethtool_test_flags {
> > +     ETH_TEST_FL_OFFLINE     = (1 << 0),
> > +     ETH_TEST_FL_FAILED      = (1 << 1),
> > +     ETH_TEST_FL_EXTERNAL_LB = (1 << 2),
> > +     ETH_TEST_FL_EXTERNAL_LB_DONE    = (1 << 3),
> > +};
> > +
> > +/**
> > + * struct ethtool_test - device self-test invocation
> > + * @cmd: Command number = %ETHTOOL_TEST
> > + * @flags: A bitmask of flags from &enum ethtool_test_flags.  Some
> > + *   flags may be set by the user on entry; others may be set by
> > + *   the driver on return.
> > + * @len: On return, the number of test results
> > + * @data: Array of test results
> > + *
> > + * Users must use %ETHTOOL_GSSET_INFO or %ETHTOOL_GDRVINFO to find the
> > + * number of test results that will be returned.  They must allocate a
> > + * buffer of the appropriate size (8 * number of results) immediately
> > + * following this structure.
> > + */
> > +struct ethtool_test {
> > +     uint32_t        cmd;
> > +     uint32_t        flags;
> > +     uint32_t        reserved;
> > +     uint32_t        len;
> > +     uint64_t        data[0];
> > +};
> > +
> > +/**
> > + * struct ethtool_stats - device-specific statistics
> > + * @cmd: Command number = %ETHTOOL_GSTATS
> > + * @n_stats: On return, the number of statistics
> > + * @data: Array of statistics
> > + *
> > + * Users must use %ETHTOOL_GSSET_INFO or %ETHTOOL_GDRVINFO to find the
> > + * number of statistics that will be returned.  They must allocate a
> > + * buffer of the appropriate size (8 * number of statistics)
> > + * immediately following this structure.
> > + */
> > +struct ethtool_stats {
> > +     uint32_t        cmd;
> > +     uint32_t        n_stats;
> > +     uint64_t        data[0];
> > +};
> > +
> > +/**
> > + * struct ethtool_perm_addr - permanent hardware address
> > + * @cmd: Command number = %ETHTOOL_GPERMADDR
> > + * @size: On entry, the size of the buffer.  On return, the size of the
> > + *   address.  The command fails if the buffer is too small.
> > + * @data: Buffer for the address
> > + *
> > + * Users must allocate the buffer immediately following this structure.
> > + * A buffer size of %MAX_ADDR_LEN should be sufficient for any address
> > + * type.
> > + */
> > +struct ethtool_perm_addr {
> > +     uint32_t        cmd;
> > +     uint32_t        size;
> > +     uint8_t data[0];
> > +};
> > +
> > +/* boolean flags controlling per-interface behavior characteristics.
> > + * When reading, the flag indicates whether or not a certain behavior
> > + * is enabled/present.  When writing, the flag indicates whether
> > + * or not the driver should turn on (set) or off (clear) a behavior.
> > + *
> > + * Some behaviors may read-only (unconditionally absent or present).
> > + * If such is the case, return EINVAL in the set-flags operation if the
> > + * flag differs from the read-only value.
> > + */
> > +enum ethtool_flags {
> > +     ETH_FLAG_TXVLAN         = (1 << 7),     /* TX VLAN offload enabled
> */
> > +     ETH_FLAG_RXVLAN         = (1 << 8),     /* RX VLAN offload enabled
> */
> > +     ETH_FLAG_LRO            = (1 << 15),    /* LRO is enabled */
> > +     ETH_FLAG_NTUPLE         = (1 << 27),    /* N-tuple filters enabled
> */
> > +     ETH_FLAG_RXHASH         = (1 << 28),
> > +};
> > +
> > +/* The following structures are for supporting RX network flow
> > + * classification and RX n-tuple configuration. Note, all multibyte
> > + * fields, e.g., ip4src, ip4dst, psrc, pdst, spi, etc. are expected to
> > + * be in network byte order.
> > + */
> > +
> > +/**
> > + * struct ethtool_tcpip4_spec - flow specification for TCP/IPv4 etc.
> > + * @ip4src: Source host
> > + * @ip4dst: Destination host
> > + * @psrc: Source port
> > + * @pdst: Destination port
> > + * @tos: Type-of-service
> > + *
> > + * This can be used to specify a TCP/IPv4, UDP/IPv4 or SCTP/IPv4 flow.
> > + */
> > +struct ethtool_tcpip4_spec {
> > +     uint32_t        ip4src;
> > +     uint32_t        ip4dst;
> > +     uint16_t        psrc;
> > +     uint16_t        pdst;
> > +     uint8_t    tos;
> > +};
> > +
> > +/**
> > + * struct ethtool_ah_espip4_spec - flow specification for IPsec/IPv4
> > + * @ip4src: Source host
> > + * @ip4dst: Destination host
> > + * @spi: Security parameters index
> > + * @tos: Type-of-service
> > + *
> > + * This can be used to specify an IPsec transport or tunnel over IPv4.
> > + */
> > +struct ethtool_ah_espip4_spec {
> > +     uint32_t        ip4src;
> > +     uint32_t        ip4dst;
> > +     uint32_t        spi;
> > +     uint8_t    tos;
> > +};
> > +
> > +#define      ETH_RX_NFC_IP4  1
> > +
> > +/**
> > + * struct ethtool_usrip4_spec - general flow specification for IPv4
> > + * @ip4src: Source host
> > + * @ip4dst: Destination host
> > + * @l4_4_bytes: First 4 bytes of transport (layer 4) header
> > + * @tos: Type-of-service
> > + * @ip_ver: Value must be %ETH_RX_NFC_IP4; mask must be 0
> > + * @proto: Transport protocol number; mask must be 0
> > + */
> > +struct ethtool_usrip4_spec {
> > +     uint32_t        ip4src;
> > +     uint32_t        ip4dst;
> > +     uint32_t        l4_4_bytes;
> > +     uint8_t    tos;
> > +     uint8_t    ip_ver;
> > +     uint8_t    proto;
> > +};
> > +
> > +/**
> > + * struct ethtool_tcpip6_spec - flow specification for TCP/IPv6 etc.
> > + * @ip6src: Source host
> > + * @ip6dst: Destination host
> > + * @psrc: Source port
> > + * @pdst: Destination port
> > + * @tclass: Traffic Class
> > + *
> > + * This can be used to specify a TCP/IPv6, UDP/IPv6 or SCTP/IPv6 flow.
> > + */
> > +struct ethtool_tcpip6_spec {
> > +     uint32_t        ip6src[4];
> > +     uint32_t        ip6dst[4];
> > +     uint16_t        psrc;
> > +     uint16_t        pdst;
> > +     uint8_t    tclass;
> > +};
> > +
> > +/**
> > + * struct ethtool_ah_espip6_spec - flow specification for IPsec/IPv6
> > + * @ip6src: Source host
> > + * @ip6dst: Destination host
> > + * @spi: Security parameters index
> > + * @tclass: Traffic Class
> > + *
> > + * This can be used to specify an IPsec transport or tunnel over IPv6.
> > + */
> > +struct ethtool_ah_espip6_spec {
> > +     uint32_t        ip6src[4];
> > +     uint32_t        ip6dst[4];
> > +     uint32_t        spi;
> > +     uint8_t    tclass;
> > +};
> > +
> > +/**
> > + * struct ethtool_usrip6_spec - general flow specification for IPv6
> > + * @ip6src: Source host
> > + * @ip6dst: Destination host
> > + * @l4_4_bytes: First 4 bytes of transport (layer 4) header
> > + * @tclass: Traffic Class
> > + * @l4_proto: Transport protocol number (nexthdr after any Extension
> Headers)
> > + */
> > +struct ethtool_usrip6_spec {
> > +     uint32_t        ip6src[4];
> > +     uint32_t        ip6dst[4];
> > +     uint32_t        l4_4_bytes;
> > +     uint8_t    tclass;
> > +     uint8_t    l4_proto;
> > +};
> > +
> > +union ethtool_flow_union {
> > +     struct ethtool_tcpip4_spec              tcp_ip4_spec;
> > +     struct ethtool_tcpip4_spec              udp_ip4_spec;
> > +     struct ethtool_tcpip4_spec              sctp_ip4_spec;
> > +     struct ethtool_ah_espip4_spec           ah_ip4_spec;
> > +     struct ethtool_ah_espip4_spec           esp_ip4_spec;
> > +     struct ethtool_usrip4_spec              usr_ip4_spec;
> > +     struct ethtool_tcpip6_spec              tcp_ip6_spec;
> > +     struct ethtool_tcpip6_spec              udp_ip6_spec;
> > +     struct ethtool_tcpip6_spec              sctp_ip6_spec;
> > +     struct ethtool_ah_espip6_spec           ah_ip6_spec;
> > +     struct ethtool_ah_espip6_spec           esp_ip6_spec;
> > +     struct ethtool_usrip6_spec              usr_ip6_spec;
> > +     struct eth_header                               ether_spec;
> > +     uint8_t                                 hdata[52];
> > +};
> > +
> > +/**
> > + * struct ethtool_flow_ext - additional RX flow fields
> > + * @h_dest: destination MAC address
> > + * @vlan_etype: VLAN EtherType
> > + * @vlan_tci: VLAN tag control information
> > + * @data: user defined data
> > + *
> > + * Note, @vlan_etype, @vlan_tci, and @data are only valid if %FLOW_EXT
> > + * is set in &struct ethtool_rx_flow_spec @flow_type.
> > + * @h_dest is valid if %FLOW_MAC_EXT is set.
> > + */
> > +struct ethtool_flow_ext {
> > +     uint8_t         padding[2];
> > +     unsigned char   h_dest[ETH_ALEN];
> > +     uint16_t                vlan_etype;
> > +     uint16_t                vlan_tci;
> > +     uint32_t                data[2];
> > +};
> > +
> > +/**
> > + * struct ethtool_rx_flow_spec - classification rule for RX flows
> > + * @flow_type: Type of match to perform, e.g. %TCP_V4_FLOW
> > + * @h_u: Flow fields to match (dependent on @flow_type)
> > + * @h_ext: Additional fields to match
> > + * @m_u: Masks for flow field bits to be matched
> > + * @m_ext: Masks for additional field bits to be matched
> > + *   Note, all additional fields must be ignored unless @flow_type
> > + *   includes the %FLOW_EXT or %FLOW_MAC_EXT flag
> > + *   (see &struct ethtool_flow_ext description).
> > + * @ring_cookie: RX ring/queue index to deliver to, or %RX_CLS_FLOW_DISC
> > + *   if packets should be discarded
> > + * @location: Location of rule in the table.  Locations must be
> > + *   numbered such that a flow matching multiple rules will be
> > + *   classified according to the first (lowest numbered) rule.
> > + */
> > +struct ethtool_rx_flow_spec {
> > +     uint32_t                flow_type;
> > +     union ethtool_flow_union h_u;
> > +     struct ethtool_flow_ext h_ext;
> > +     union ethtool_flow_union m_u;
> > +     struct ethtool_flow_ext m_ext;
> > +     uint64_t                ring_cookie;
> > +     uint32_t                location;
> > +};
> > +
> > +/* How rings are layed out when accessing virtual functions or
> > + * offloaded queues is device specific. To allow users to do flow
> > + * steering and specify these queues the ring cookie is partitioned
> > + * into a 32bit queue index with an 8 bit virtual function id.
> > + * This also leaves the 3bytes for further specifiers. It is possible
> > + * future devices may support more than 256 virtual functions if
> > + * devices start supporting PCIe w/ARI. However at the moment I
> > + * do not know of any devices that support this so I do not reserve
> > + * space for this at this time. If a future patch consumes the next
> > + * byte it should be aware of this possiblity.
> > + */
> > +#define ETHTOOL_RX_FLOW_SPEC_RING    0x00000000FFFFFFFFLL
> > +#define ETHTOOL_RX_FLOW_SPEC_RING_VF 0x000000FF00000000LL
> > +#define ETHTOOL_RX_FLOW_SPEC_RING_VF_OFF 32
> > +static inline uint64_t ethtool_get_flow_spec_ring(uint64_t ring_cookie)
> > +{
> > +     return ETHTOOL_RX_FLOW_SPEC_RING & ring_cookie;
> > +};
> > +
> > +static inline uint64_t ethtool_get_flow_spec_ring_vf(uint64_t
> ring_cookie)
> > +{
> > +     return (ETHTOOL_RX_FLOW_SPEC_RING_VF & ring_cookie) >>
> > +                             ETHTOOL_RX_FLOW_SPEC_RING_VF_OFF;
> > +};
> > +
> > +/**
> > + * struct ethtool_rxnfc - command to get or set RX flow classification
> rules
> > + * @cmd: Specific command number - %ETHTOOL_GRXFH, %ETHTOOL_SRXFH,
> > + *   %ETHTOOL_GRXRINGS, %ETHTOOL_GRXCLSRLCNT, %ETHTOOL_GRXCLSRULE,
> > + *   %ETHTOOL_GRXCLSRLALL, %ETHTOOL_SRXCLSRLDEL or %ETHTOOL_SRXCLSRLINS
> > + * @flow_type: Type of flow to be affected, e.g. %TCP_V4_FLOW
> > + * @data: Command-dependent value
> > + * @fs: Flow classification rule
> > + * @rule_cnt: Number of rules to be affected
> > + * @rule_locs: Array of used rule locations
> > + *
> > + * For %ETHTOOL_GRXFH and %ETHTOOL_SRXFH, @data is a bitmask indicating
> > + * the fields included in the flow hash, e.g. %RXH_IP_SRC.  The
> following
> > + * structure fields must not be used.
> > + *
> > + * For %ETHTOOL_GRXRINGS, @data is set to the number of RX rings/queues
> > + * on return.
> > + *
> > + * For %ETHTOOL_GRXCLSRLCNT, @rule_cnt is set to the number of defined
> > + * rules on return.  If @data is non-zero on return then it is the
> > + * size of the rule table, plus the flag %RX_CLS_LOC_SPECIAL if the
> > + * driver supports any special location values.  If that flag is not
> > + * set in @data then special location values should not be used.
> > + *
> > + * For %ETHTOOL_GRXCLSRULE, @fs.@location specifies the location of an
> > + * existing rule on entry and @fs contains the rule on return.
> > + *
> > + * For %ETHTOOL_GRXCLSRLALL, @rule_cnt specifies the array size of the
> > + * user buffer for @rule_locs on entry.  On return, @data is the size
> > + * of the rule table, @rule_cnt is the number of defined rules, and
> > + * @rule_locs contains the locations of the defined rules.  Drivers
> > + * must use the second parameter to get_rxnfc() instead of @rule_locs.
> > + *
> > + * For %ETHTOOL_SRXCLSRLINS, @fs specifies the rule to add or update.
> > + * @fs.@location either specifies the location to use or is a special
> > + * location value with %RX_CLS_LOC_SPECIAL flag set.  On return,
> > + * @fs.@location is the actual rule location.
> > + *
> > + * For %ETHTOOL_SRXCLSRLDEL, @fs.@location specifies the location of an
> > + * existing rule on entry.
> > + *
> > + * A driver supporting the special location values for
> > + * %ETHTOOL_SRXCLSRLINS may add the rule at any suitable unused
> > + * location, and may remove a rule at a later location (lower
> > + * priority) that matches exactly the same set of flows.  The special
> > + * values are %RX_CLS_LOC_ANY, selecting any location;
> > + * %RX_CLS_LOC_FIRST, selecting the first suitable location (maximum
> > + * priority); and %RX_CLS_LOC_LAST, selecting the last suitable
> > + * location (minimum priority).  Additional special values may be
> > + * defined in future and drivers must return -%EINVAL for any
> > + * unrecognised value.
> > + */
> > +struct ethtool_rxnfc {
> > +     uint32_t                                cmd;
> > +     uint32_t                                flow_type;
> > +     uint64_t                                data;
> > +     struct ethtool_rx_flow_spec     fs;
> > +     uint32_t                                rule_cnt;
> > +     uint32_t                                rule_locs[0];
> > +};
> > +
> > +
> > +/**
> > + * struct ethtool_rxfh_indir - command to get or set RX flow hash
> indirection
> > + * @cmd: Specific command number - %ETHTOOL_GRXFHINDIR or
> %ETHTOOL_SRXFHINDIR
> > + * @size: On entry, the array size of the user buffer, which may be
> zero.
> > + *   On return from %ETHTOOL_GRXFHINDIR, the array size of the hardware
> > + *   indirection table.
> > + * @ring_index: RX ring/queue index for each hash value
> > + *
> > + * For %ETHTOOL_GRXFHINDIR, a @size of zero means that only the size
> > + * should be returned.  For %ETHTOOL_SRXFHINDIR, a @size of zero means
> > + * the table should be reset to default values.  This last feature
> > + * is not supported by the original implementations.
> > + */
> > +struct ethtool_rxfh_indir {
> > +     uint32_t        cmd;
> > +     uint32_t        size;
> > +     uint32_t        ring_index[0];
> > +};
> > +
> > +/**
> > + * struct ethtool_rxfh - command to get/set RX flow hash indir or/and
> hash key.
> > + * @cmd: Specific command number - %ETHTOOL_GRSSH or %ETHTOOL_SRSSH
> > + * @rss_context: RSS context identifier.
> > + * @indir_size: On entry, the array size of the user buffer for the
> > + *   indirection table, which may be zero, or (for %ETHTOOL_SRSSH),
> > + *   %ETH_RXFH_INDIR_NO_CHANGE.  On return from %ETHTOOL_GRSSH,
> > + *   the array size of the hardware indirection table.
> > + * @key_size: On entry, the array size of the user buffer for the hash
> key,
> > + *   which may be zero.  On return from %ETHTOOL_GRSSH, the size of the
> > + *   hardware hash key.
> > + * @hfunc: Defines the current RSS hash function used by HW (or to be
> set to).
> > + *   Valid values are one of the %ETH_RSS_HASH_*.
> > + * @rsvd:    Reserved for future extensions.
> > + * @rss_config: RX ring/queue index for each hash value i.e.,
> indirection table
> > + *   of @indir_size uint32_t elements, followed by hash key of @key_size
> > + *   bytes.
> > + *
> > + * For %ETHTOOL_GRSSH, a @indir_size and key_size of zero means that
> only the
> > + * size should be returned.  For %ETHTOOL_SRSSH, an @indir_size of
> > + * %ETH_RXFH_INDIR_NO_CHANGE means that indir table setting is not
> requested
> > + * and a @indir_size of zero means the indir table should be reset to
> default
> > + * values. An hfunc of zero means that hash function setting is not
> requested.
> > + */
> > +struct ethtool_rxfh {
> > +     uint32_t   cmd;
> > +     uint32_t        rss_context;
> > +     uint32_t   indir_size;
> > +     uint32_t   key_size;
> > +     uint8_t hfunc;
> > +     uint8_t rsvd8[3];
> > +     uint32_t        rsvd32;
> > +     uint32_t   rss_config[0];
> > +};
> > +#define ETH_RXFH_INDIR_NO_CHANGE     0xffffffff
> > +
> > +/**
> > + * struct ethtool_rx_ntuple_flow_spec - specification for RX flow filter
> > + * @flow_type: Type of match to perform, e.g. %TCP_V4_FLOW
> > + * @h_u: Flow field values to match (dependent on @flow_type)
> > + * @m_u: Masks for flow field value bits to be ignored
> > + * @vlan_tag: VLAN tag to match
> > + * @vlan_tag_mask: Mask for VLAN tag bits to be ignored
> > + * @data: Driver-dependent data to match
> > + * @data_mask: Mask for driver-dependent data bits to be ignored
> > + * @action: RX ring/queue index to deliver to (non-negative) or other
> action
> > + *   (negative, e.g. %ETHTOOL_RXNTUPLE_ACTION_DROP)
> > + *
> > + * For flow types %TCP_V4_FLOW, %UDP_V4_FLOW and %SCTP_V4_FLOW, where
> > + * a field value and mask are both zero this is treated as if all mask
> > + * bits are set i.e. the field is ignored.
> > + */
> > +struct ethtool_rx_ntuple_flow_spec {
> > +     uint32_t                 flow_type;
> > +     union {
> > +             struct ethtool_tcpip4_spec              tcp_ip4_spec;
> > +             struct ethtool_tcpip4_spec              udp_ip4_spec;
> > +             struct ethtool_tcpip4_spec              sctp_ip4_spec;
> > +             struct ethtool_ah_espip4_spec           ah_ip4_spec;
> > +             struct ethtool_ah_espip4_spec           esp_ip4_spec;
> > +             struct ethtool_usrip4_spec              usr_ip4_spec;
> > +             struct eth_header                               ether_spec;
> > +             uint8_t                                 hdata[72];
> > +     } h_u, m_u;
> > +
> > +     uint16_t                vlan_tag;
> > +     uint16_t                vlan_tag_mask;
> > +     uint64_t                data;
> > +     uint64_t                data_mask;
> > +
> > +     int32_t         action;
> > +#define ETHTOOL_RXNTUPLE_ACTION_DROP (-1)    /* drop packet */
> > +#define ETHTOOL_RXNTUPLE_ACTION_CLEAR        (-2)    /* clear filter */
> > +};
> > +
> > +/**
> > + * struct ethtool_rx_ntuple - command to set or clear RX flow filter
> > + * @cmd: Command number - %ETHTOOL_SRXNTUPLE
> > + * @fs: Flow filter specification
> > + */
> > +struct ethtool_rx_ntuple {
> > +     uint32_t                                        cmd;
> > +     struct ethtool_rx_ntuple_flow_spec      fs;
> > +};
> > +
> > +#define ETHTOOL_FLASH_MAX_FILENAME   128
> > +enum ethtool_flash_op_type {
> > +     ETHTOOL_FLASH_ALL_REGIONS       = 0,
> > +};
> > +
> > +/* for passing firmware flashing related parameters */
> > +struct ethtool_flash {
> > +     uint32_t        cmd;
> > +     uint32_t        region;
> > +     char    data[ETHTOOL_FLASH_MAX_FILENAME];
> > +};
> > +
> > +/**
> > + * struct ethtool_dump - used for retrieving, setting device dump
> > + * @cmd: Command number - %ETHTOOL_GET_DUMP_FLAG,
> %ETHTOOL_GET_DUMP_DATA, or
> > + *   %ETHTOOL_SET_DUMP
> > + * @version: FW version of the dump, filled in by driver
> > + * @flag: driver dependent flag for dump setting, filled in by driver
> during
> > + *        get and filled in by ethtool for set operation.
> > + *        flag must be initialized by macro ETH_FW_DUMP_DISABLE value
> when
> > + *        firmware dump is disabled.
> > + * @len: length of dump data, used as the length of the user buffer on
> entry to
> > + *    %ETHTOOL_GET_DUMP_DATA and this is returned as dump length by
> driver
> > + *    for %ETHTOOL_GET_DUMP_FLAG command
> > + * @data: data collected for get dump data operation
> > + */
> > +struct ethtool_dump {
> > +     uint32_t        cmd;
> > +     uint32_t        version;
> > +     uint32_t        flag;
> > +     uint32_t        len;
> > +     uint8_t data[0];
> > +};
> > +
> > +#define ETH_FW_DUMP_DISABLE 0
> > +
> > +/* for returning and changing feature sets */
> > +
> > +/**
> > + * struct ethtool_get_features_block - block with state of 32 features
> > + * @available: mask of changeable features
> > + * @requested: mask of features requested to be enabled if possible
> > + * @active: mask of currently enabled features
> > + * @never_changed: mask of features not changeable for any device
> > + */
> > +struct ethtool_get_features_block {
> > +     uint32_t        available;
> > +     uint32_t        requested;
> > +     uint32_t        active;
> > +     uint32_t        never_changed;
> > +};
> > +
> > +/**
> > + * struct ethtool_gfeatures - command to get state of device's features
> > + * @cmd: command number = %ETHTOOL_GFEATURES
> > + * @size: On entry, the number of elements in the features[] array;
> > + *   on return, the number of elements in features[] needed to hold
> > + *   all features
> > + * @features: state of features
> > + */
> > +struct ethtool_gfeatures {
> > +     uint32_t        cmd;
> > +     uint32_t        size;
> > +     struct ethtool_get_features_block features[0];
> > +};
> > +
> > +/**
> > + * struct ethtool_set_features_block - block with request for 32
> features
> > + * @valid: mask of features to be changed
> > + * @requested: values of features to be changed
> > + */
> > +struct ethtool_set_features_block {
> > +     uint32_t        valid;
> > +     uint32_t        requested;
> > +};
> > +
> > +/**
> > + * struct ethtool_sfeatures - command to request change in device's
> features
> > + * @cmd: command number = %ETHTOOL_SFEATURES
> > + * @size: array size of the features[] array
> > + * @features: feature change masks
> > + */
> > +struct ethtool_sfeatures {
> > +     uint32_t        cmd;
> > +     uint32_t        size;
> > +     struct ethtool_set_features_block features[0];
> > +};
> > +
> > +/**
> > + * struct ethtool_ts_info - holds a device's timestamping and PHC
> association
> > + * @cmd: command number = %ETHTOOL_GET_TS_INFO
> > + * @so_timestamping: bit mask of the sum of the supported
> SO_TIMESTAMPING flags
> > + * @phc_index: device index of the associated PHC, or -1 if there is
> none
> > + * @tx_types: bit mask of the supported hwtstamp_tx_types enumeration
> values
> > + * @rx_filters: bit mask of the supported hwtstamp_rx_filters
> enumeration values
> > + *
> > + * The bits in the 'tx_types' and 'rx_filters' fields correspond to
> > + * the 'hwtstamp_tx_types' and 'hwtstamp_rx_filters' enumeration values,
> > + * respectively.  For example, if the device supports HWTSTAMP_TX_ON,
> > + * then (1 << HWTSTAMP_TX_ON) in 'tx_types' will be set.
> > + *
> > + * Drivers should only report the filters they actually support without
> > + * upscaling in the SIOCSHWTSTAMP ioctl. If the SIOCSHWSTAMP request for
> > + * HWTSTAMP_FILTER_V1_SYNC is supported by HWTSTAMP_FILTER_V1_EVENT,
> then the
> > + * driver should only report HWTSTAMP_FILTER_V1_EVENT in this op.
> > + */
> > +struct ethtool_ts_info {
> > +     uint32_t        cmd;
> > +     uint32_t        so_timestamping;
> > +     int32_t phc_index;
> > +     uint32_t        tx_types;
> > +     uint32_t        tx_reserved[3];
> > +     uint32_t        rx_filters;
> > +     uint32_t        rx_reserved[3];
> > +};
> > +
> > +/*
> > + * %ETHTOOL_SFEATURES changes features present in features[].valid to
> the
> > + * values of corresponding bits in features[].requested. Bits in
> .requested
> > + * not set in .valid or not changeable are ignored.
> > + *
> > + * Returns %EINVAL when .valid contains undefined or never-changeable
> bits
> > + * or size is not equal to required number of features words (32-bit
> blocks).
> > + * Returns >= 0 if request was completed; bits set in the value mean:
> > + *   %ETHTOOL_F_UNSUPPORTED - there were bits set in .valid that are not
> > + *   changeable (not present in %ETHTOOL_GFEATURES'
> features[].available)
> > + *   those bits were ignored.
> > + *   %ETHTOOL_F_WISH - some or all changes requested were recorded but
> the
> > + *      resulting state of bits masked by .valid is not equal to
> .requested.
> > + *      Probably there are other device-specific constraints on some
> features
> > + *      in the set. When %ETHTOOL_F_UNSUPPORTED is set, .valid is
> considered
> > + *      here as though ignored bits were cleared.
> > + *   %ETHTOOL_F_COMPAT - some or all changes requested were made by
> calling
> > + *      compatibility functions. Requested offload state cannot be
> properly
> > + *      managed by kernel.
> > + *
> > + * Meaning of bits in the masks are obtained by %ETHTOOL_GSSET_INFO
> (number of
> > + * bits in the arrays - always multiple of 32) and %ETHTOOL_GSTRINGS
> commands
> > + * for ETH_SS_FEATURES string set. First entry in the table corresponds
> to least
> > + * significant bit in features[0] fields. Empty strings mark undefined
> features.
> > + */
> > +enum ethtool_sfeatures_retval_bits {
> > +     ETHTOOL_F_UNSUPPORTED__BIT,
> > +     ETHTOOL_F_WISH__BIT,
> > +     ETHTOOL_F_COMPAT__BIT,
> > +};
> > +
> > +#define ETHTOOL_F_UNSUPPORTED   (1 << ETHTOOL_F_UNSUPPORTED__BIT)
> > +#define ETHTOOL_F_WISH          (1 << ETHTOOL_F_WISH__BIT)
> > +#define ETHTOOL_F_COMPAT        (1 << ETHTOOL_F_COMPAT__BIT)
> > +
> > +#define MAX_NUM_QUEUE                4096
> > +
> > +/**
> > + * struct ethtool_per_queue_op - apply sub command to the queues in
> mask.
> > + * @cmd: ETHTOOL_PERQUEUE
> > + * @sub_command: the sub command which apply to each queues
> > + * @queue_mask: Bitmap of the queues which sub command apply to
> > + * @data: A complete command structure following for each of the queues
> addressed
> > + */
> > +struct ethtool_per_queue_op {
> > +     uint32_t        cmd;
> > +     uint32_t        sub_command;
> > +     uint32_t        queue_mask[__KERNEL_DIV_ROUND_UP(MAX_NUM_QUEUE,
> 32)];
> > +     char    data[];
> > +};
> > +
> > +/**
> > + * struct ethtool_fecparam - Ethernet forward error correction(fec)
> parameters
> > + * @cmd: Command number = %ETHTOOL_GFECPARAM or %ETHTOOL_SFECPARAM
> > + * @active_fec: FEC mode which is active on porte
> > + * @fec: Bitmask of supported/configured FEC modes
> > + * @rsvd: Reserved for future extensions. i.e FEC bypass feature.
> > + *
> > + * Drivers should reject a non-zero setting of @autoneg when
> > + * autoneogotiation is disabled (or not supported) for the link.
> > + *
> > + */
> > +struct ethtool_fecparam {
> > +     uint32_t   cmd;
> > +     /* bitmask of FEC modes */
> > +     uint32_t   active_fec;
> > +     uint32_t   fec;
> > +     uint32_t   reserved;
> > +};
> > +
> > +/**
> > + * enum ethtool_fec_config_bits - flags definition of
> ethtool_fec_configuration
> > + * @ETHTOOL_FEC_NONE: FEC mode configuration is not supported
> > + * @ETHTOOL_FEC_AUTO: Default/Best FEC mode provided by driver
> > + * @ETHTOOL_FEC_OFF: No FEC Mode
> > + * @ETHTOOL_FEC_RS: Reed-Solomon Forward Error Detection mode
> > + * @ETHTOOL_FEC_BASER: Base-R/Reed-Solomon Forward Error Detection mode
> > + */
> > +enum ethtool_fec_config_bits {
> > +     ETHTOOL_FEC_NONE_BIT,
> > +     ETHTOOL_FEC_AUTO_BIT,
> > +     ETHTOOL_FEC_OFF_BIT,
> > +     ETHTOOL_FEC_RS_BIT,
> > +     ETHTOOL_FEC_BASER_BIT,
> > +};
> > +
> > +#define ETHTOOL_FEC_NONE             (1 << ETHTOOL_FEC_NONE_BIT)
> > +#define ETHTOOL_FEC_AUTO             (1 << ETHTOOL_FEC_AUTO_BIT)
> > +#define ETHTOOL_FEC_OFF                      (1 << ETHTOOL_FEC_OFF_BIT)
> > +#define ETHTOOL_FEC_RS                       (1 << ETHTOOL_FEC_RS_BIT)
> > +#define ETHTOOL_FEC_BASER            (1 << ETHTOOL_FEC_BASER_BIT)
> > +
> > +/* CMDs currently supported */
> > +#define ETHTOOL_GSET         0x00000001 /* DEPRECATED, Get settings.
> > +                                         * Please use
> ETHTOOL_GLINKSETTINGS
> > +                                         */
> > +#define ETHTOOL_SSET         0x00000002 /* DEPRECATED, Set settings.
> > +                                         * Please use
> ETHTOOL_SLINKSETTINGS
> > +                                         */
> > +#define ETHTOOL_GDRVINFO     0x00000003 /* Get driver info. */
> > +#define ETHTOOL_GREGS                0x00000004 /* Get NIC registers. */
> > +#define ETHTOOL_GWOL         0x00000005 /* Get wake-on-lan options. */
> > +#define ETHTOOL_SWOL         0x00000006 /* Set wake-on-lan options. */
> > +#define ETHTOOL_GMSGLVL              0x00000007 /* Get driver message
> level */
> > +#define ETHTOOL_SMSGLVL              0x00000008 /* Set driver msg
> level. */
> > +#define ETHTOOL_NWAY_RST     0x00000009 /* Restart autonegotiation. */
> > +/* Get link status for host, i.e. whether the interface *and* the
> > + * physical port (if there is one) are up (ethtool_value). */
> > +#define ETHTOOL_GLINK                0x0000000a
> > +#define ETHTOOL_GEEPROM              0x0000000b /* Get EEPROM data */
> > +#define ETHTOOL_SEEPROM              0x0000000c /* Set EEPROM data. */
> > +#define ETHTOOL_GCOALESCE    0x0000000e /* Get coalesce config */
> > +#define ETHTOOL_SCOALESCE    0x0000000f /* Set coalesce config. */
> > +#define ETHTOOL_GRINGPARAM   0x00000010 /* Get ring parameters */
> > +#define ETHTOOL_SRINGPARAM   0x00000011 /* Set ring parameters. */
> > +#define ETHTOOL_GPAUSEPARAM  0x00000012 /* Get pause parameters */
> > +#define ETHTOOL_SPAUSEPARAM  0x00000013 /* Set pause parameters. */
> > +#define ETHTOOL_GRXCSUM              0x00000014 /* Get RX hw csum
> enable (ethtool_value) */
> > +#define ETHTOOL_SRXCSUM              0x00000015 /* Set RX hw csum
> enable (ethtool_value) */
> > +#define ETHTOOL_GTXCSUM              0x00000016 /* Get TX hw csum
> enable (ethtool_value) */
> > +#define ETHTOOL_STXCSUM              0x00000017 /* Set TX hw csum
> enable (ethtool_value) */
> > +#define ETHTOOL_GSG          0x00000018 /* Get scatter-gather enable
> > +                                         * (ethtool_value) */
> > +#define ETHTOOL_SSG          0x00000019 /* Set scatter-gather enable
> > +                                         * (ethtool_value). */
> > +#define ETHTOOL_TEST         0x0000001a /* execute NIC self-test. */
> > +#define ETHTOOL_GSTRINGS     0x0000001b /* get specified string set */
> > +#define ETHTOOL_PHYS_ID              0x0000001c /* identify the NIC */
> > +#define ETHTOOL_GSTATS               0x0000001d /* get NIC-specific
> statistics */
> > +#define ETHTOOL_GTSO         0x0000001e /* Get TSO enable
> (ethtool_value) */
> > +#define ETHTOOL_STSO         0x0000001f /* Set TSO enable
> (ethtool_value) */
> > +#define ETHTOOL_GPERMADDR    0x00000020 /* Get permanent hardware
> address */
> > +#define ETHTOOL_GUFO         0x00000021 /* Get UFO enable
> (ethtool_value) */
> > +#define ETHTOOL_SUFO         0x00000022 /* Set UFO enable
> (ethtool_value) */
> > +#define ETHTOOL_GGSO         0x00000023 /* Get GSO enable
> (ethtool_value) */
> > +#define ETHTOOL_SGSO         0x00000024 /* Set GSO enable
> (ethtool_value) */
> > +#define ETHTOOL_GFLAGS               0x00000025 /* Get flags
> bitmap(ethtool_value) */
> > +#define ETHTOOL_SFLAGS               0x00000026 /* Set flags
> bitmap(ethtool_value) */
> > +#define ETHTOOL_GPFLAGS              0x00000027 /* Get driver-private
> flags bitmap */
> > +#define ETHTOOL_SPFLAGS              0x00000028 /* Set driver-private
> flags bitmap */
> > +
> > +#define ETHTOOL_GRXFH                0x00000029 /* Get RX flow hash
> configuration */
> > +#define ETHTOOL_SRXFH                0x0000002a /* Set RX flow hash
> configuration */
> > +#define ETHTOOL_GGRO         0x0000002b /* Get GRO enable
> (ethtool_value) */
> > +#define ETHTOOL_SGRO         0x0000002c /* Set GRO enable
> (ethtool_value) */
> > +#define ETHTOOL_GRXRINGS     0x0000002d /* Get RX rings available for
> LB */
> > +#define ETHTOOL_GRXCLSRLCNT  0x0000002e /* Get RX class rule count */
> > +#define ETHTOOL_GRXCLSRULE   0x0000002f /* Get RX classification rule */
> > +#define ETHTOOL_GRXCLSRLALL  0x00000030 /* Get all RX classification
> rule */
> > +#define ETHTOOL_SRXCLSRLDEL  0x00000031 /* Delete RX classification
> rule */
> > +#define ETHTOOL_SRXCLSRLINS  0x00000032 /* Insert RX classification
> rule */
> > +#define ETHTOOL_FLASHDEV     0x00000033 /* Flash firmware to device */
> > +#define ETHTOOL_RESET                0x00000034 /* Reset hardware */
> > +#define ETHTOOL_SRXNTUPLE    0x00000035 /* Add an n-tuple filter to
> device */
> > +#define ETHTOOL_GRXNTUPLE    0x00000036 /* deprecated */
> > +#define ETHTOOL_GSSET_INFO   0x00000037 /* Get string set info */
> > +#define ETHTOOL_GRXFHINDIR   0x00000038 /* Get RX flow hash indir'n
> table */
> > +#define ETHTOOL_SRXFHINDIR   0x00000039 /* Set RX flow hash indir'n
> table */
> > +
> > +#define ETHTOOL_GFEATURES    0x0000003a /* Get device offload settings
> */
> > +#define ETHTOOL_SFEATURES    0x0000003b /* Change device offload
> settings */
> > +#define ETHTOOL_GCHANNELS    0x0000003c /* Get no of channels */
> > +#define ETHTOOL_SCHANNELS    0x0000003d /* Set no of channels */
> > +#define ETHTOOL_SET_DUMP     0x0000003e /* Set dump settings */
> > +#define ETHTOOL_GET_DUMP_FLAG        0x0000003f /* Get dump settings */
> > +#define ETHTOOL_GET_DUMP_DATA        0x00000040 /* Get dump data */
> > +#define ETHTOOL_GET_TS_INFO  0x00000041 /* Get time stamping and PHC
> info */
> > +#define ETHTOOL_GMODULEINFO  0x00000042 /* Get plug-in module
> information */
> > +#define ETHTOOL_GMODULEEEPROM        0x00000043 /* Get plug-in module
> eeprom */
> > +#define ETHTOOL_GEEE         0x00000044 /* Get EEE settings */
> > +#define ETHTOOL_SEEE         0x00000045 /* Set EEE settings */
> > +
> > +#define ETHTOOL_GRSSH                0x00000046 /* Get RX flow hash
> configuration */
> > +#define ETHTOOL_SRSSH                0x00000047 /* Set RX flow hash
> configuration */
> > +#define ETHTOOL_GTUNABLE     0x00000048 /* Get tunable configuration */
> > +#define ETHTOOL_STUNABLE     0x00000049 /* Set tunable configuration */
> > +#define ETHTOOL_GPHYSTATS    0x0000004a /* get PHY-specific statistics
> */
> > +
> > +#define ETHTOOL_PERQUEUE     0x0000004b /* Set per queue options */
> > +
> > +#define ETHTOOL_GLINKSETTINGS        0x0000004c /* Get
> ethtool_link_settings */
> > +#define ETHTOOL_SLINKSETTINGS        0x0000004d /* Set
> ethtool_link_settings */
> > +#define ETHTOOL_PHY_GTUNABLE 0x0000004e /* Get PHY tunable
> configuration */
> > +#define ETHTOOL_PHY_STUNABLE 0x0000004f /* Set PHY tunable
> configuration */
> > +#define ETHTOOL_GFECPARAM    0x00000050 /* Get FEC settings */
> > +#define ETHTOOL_SFECPARAM    0x00000051 /* Set FEC settings */
> > +
> > +/* compatibility with older code */
> > +#define SPARC_ETH_GSET               ETHTOOL_GSET
> > +#define SPARC_ETH_SSET               ETHTOOL_SSET
> > +
> > +/* Link mode bit indices */
> > +enum ethtool_link_mode_bit_indices {
> > +     ETHTOOL_LINK_MODE_10baseT_Half_BIT      = 0,
> > +     ETHTOOL_LINK_MODE_10baseT_Full_BIT      = 1,
> > +     ETHTOOL_LINK_MODE_100baseT_Half_BIT     = 2,
> > +     ETHTOOL_LINK_MODE_100baseT_Full_BIT     = 3,
> > +     ETHTOOL_LINK_MODE_1000baseT_Half_BIT    = 4,
> > +     ETHTOOL_LINK_MODE_1000baseT_Full_BIT    = 5,
> > +     ETHTOOL_LINK_MODE_Autoneg_BIT           = 6,
> > +     ETHTOOL_LINK_MODE_TP_BIT                = 7,
> > +     ETHTOOL_LINK_MODE_AUI_BIT               = 8,
> > +     ETHTOOL_LINK_MODE_MII_BIT               = 9,
> > +     ETHTOOL_LINK_MODE_FIBRE_BIT             = 10,
> > +     ETHTOOL_LINK_MODE_BNC_BIT               = 11,
> > +     ETHTOOL_LINK_MODE_10000baseT_Full_BIT   = 12,
> > +     ETHTOOL_LINK_MODE_Pause_BIT             = 13,
> > +     ETHTOOL_LINK_MODE_Asym_Pause_BIT        = 14,
> > +     ETHTOOL_LINK_MODE_2500baseX_Full_BIT    = 15,
> > +     ETHTOOL_LINK_MODE_Backplane_BIT         = 16,
> > +     ETHTOOL_LINK_MODE_1000baseKX_Full_BIT   = 17,
> > +     ETHTOOL_LINK_MODE_10000baseKX4_Full_BIT = 18,
> > +     ETHTOOL_LINK_MODE_10000baseKR_Full_BIT  = 19,
> > +     ETHTOOL_LINK_MODE_10000baseR_FEC_BIT    = 20,
> > +     ETHTOOL_LINK_MODE_20000baseMLD2_Full_BIT = 21,
> > +     ETHTOOL_LINK_MODE_20000baseKR2_Full_BIT = 22,
> > +     ETHTOOL_LINK_MODE_40000baseKR4_Full_BIT = 23,
> > +     ETHTOOL_LINK_MODE_40000baseCR4_Full_BIT = 24,
> > +     ETHTOOL_LINK_MODE_40000baseSR4_Full_BIT = 25,
> > +     ETHTOOL_LINK_MODE_40000baseLR4_Full_BIT = 26,
> > +     ETHTOOL_LINK_MODE_56000baseKR4_Full_BIT = 27,
> > +     ETHTOOL_LINK_MODE_56000baseCR4_Full_BIT = 28,
> > +     ETHTOOL_LINK_MODE_56000baseSR4_Full_BIT = 29,
> > +     ETHTOOL_LINK_MODE_56000baseLR4_Full_BIT = 30,
> > +     ETHTOOL_LINK_MODE_25000baseCR_Full_BIT  = 31,
> > +     ETHTOOL_LINK_MODE_25000baseKR_Full_BIT  = 32,
> > +     ETHTOOL_LINK_MODE_25000baseSR_Full_BIT  = 33,
> > +     ETHTOOL_LINK_MODE_50000baseCR2_Full_BIT = 34,
> > +     ETHTOOL_LINK_MODE_50000baseKR2_Full_BIT = 35,
> > +     ETHTOOL_LINK_MODE_100000baseKR4_Full_BIT        = 36,
> > +     ETHTOOL_LINK_MODE_100000baseSR4_Full_BIT        = 37,
> > +     ETHTOOL_LINK_MODE_100000baseCR4_Full_BIT        = 38,
> > +     ETHTOOL_LINK_MODE_100000baseLR4_ER4_Full_BIT    = 39,
> > +     ETHTOOL_LINK_MODE_50000baseSR2_Full_BIT         = 40,
> > +     ETHTOOL_LINK_MODE_1000baseX_Full_BIT    = 41,
> > +     ETHTOOL_LINK_MODE_10000baseCR_Full_BIT  = 42,
> > +     ETHTOOL_LINK_MODE_10000baseSR_Full_BIT  = 43,
> > +     ETHTOOL_LINK_MODE_10000baseLR_Full_BIT  = 44,
> > +     ETHTOOL_LINK_MODE_10000baseLRM_Full_BIT = 45,
> > +     ETHTOOL_LINK_MODE_10000baseER_Full_BIT  = 46,
> > +     ETHTOOL_LINK_MODE_2500baseT_Full_BIT    = 47,
> > +     ETHTOOL_LINK_MODE_5000baseT_Full_BIT    = 48,
> > +
> > +     ETHTOOL_LINK_MODE_FEC_NONE_BIT  = 49,
> > +     ETHTOOL_LINK_MODE_FEC_RS_BIT    = 50,
> > +     ETHTOOL_LINK_MODE_FEC_BASER_BIT = 51,
> > +
> > +     /* Last allowed bit for __ETHTOOL_LINK_MODE_LEGACY_MASK is bit
> > +      * 31. Please do NOT define any SUPPORTED_* or ADVERTISED_*
> > +      * macro for bits > 31. The only way to use indices > 31 is to
> > +      * use the new ETHTOOL_GLINKSETTINGS/ETHTOOL_SLINKSETTINGS API.
> > +      */
> > +
> > +     __ETHTOOL_LINK_MODE_LAST
> > +       = ETHTOOL_LINK_MODE_FEC_BASER_BIT,
> > +};
> > +
> > +#define __ETHTOOL_LINK_MODE_LEGACY_MASK(base_name)   \
> > +     (1UL << (ETHTOOL_LINK_MODE_ ## base_name ## _BIT))
> > +
> > +/* DEPRECATED macros. Please migrate to
> > + * ETHTOOL_GLINKSETTINGS/ETHTOOL_SLINKSETTINGS API. Please do NOT
> > + * define any new SUPPORTED_* macro for bits > 31.
> > + */
> > +#define SUPPORTED_10baseT_Half               __ETHTOOL_LINK_MODE_LEGACY_
> MASK(10baseT_Half)
> > +#define SUPPORTED_10baseT_Full               __ETHTOOL_LINK_MODE_LEGACY_
> MASK(10baseT_Full)
> > +#define SUPPORTED_100baseT_Half              __ETHTOOL_LINK_MODE_LEGACY_
> MASK(100baseT_Half)
> > +#define SUPPORTED_100baseT_Full              __ETHTOOL_LINK_MODE_LEGACY_
> MASK(100baseT_Full)
> > +#define SUPPORTED_1000baseT_Half     __ETHTOOL_LINK_MODE_LEGACY_
> MASK(1000baseT_Half)
> > +#define SUPPORTED_1000baseT_Full     __ETHTOOL_LINK_MODE_LEGACY_
> MASK(1000baseT_Full)
> > +#define SUPPORTED_Autoneg            __ETHTOOL_LINK_MODE_LEGACY_
> MASK(Autoneg)
> > +#define SUPPORTED_TP                 __ETHTOOL_LINK_MODE_LEGACY_
> MASK(TP)
> > +#define SUPPORTED_AUI                        __ETHTOOL_LINK_MODE_LEGACY_
> MASK(AUI)
> > +#define SUPPORTED_MII                        __ETHTOOL_LINK_MODE_LEGACY_
> MASK(MII)
> > +#define SUPPORTED_FIBRE                      __ETHTOOL_LINK_MODE_LEGACY_
> MASK(FIBRE)
> > +#define SUPPORTED_BNC                        __ETHTOOL_LINK_MODE_LEGACY_
> MASK(BNC)
> > +#define SUPPORTED_10000baseT_Full    __ETHTOOL_LINK_MODE_LEGACY_
> MASK(10000baseT_Full)
> > +#define SUPPORTED_Pause                      __ETHTOOL_LINK_MODE_LEGACY_
> MASK(Pause)
> > +#define SUPPORTED_Asym_Pause         __ETHTOOL_LINK_MODE_LEGACY_
> MASK(Asym_Pause)
> > +#define SUPPORTED_2500baseX_Full     __ETHTOOL_LINK_MODE_LEGACY_
> MASK(2500baseX_Full)
> > +#define SUPPORTED_Backplane          __ETHTOOL_LINK_MODE_LEGACY_
> MASK(Backplane)
> > +#define SUPPORTED_1000baseKX_Full    __ETHTOOL_LINK_MODE_LEGACY_
> MASK(1000baseKX_Full)
> > +#define SUPPORTED_10000baseKX4_Full  __ETHTOOL_LINK_MODE_LEGACY_
> MASK(10000baseKX4_Full)
> > +#define SUPPORTED_10000baseKR_Full   __ETHTOOL_LINK_MODE_LEGACY_
> MASK(10000baseKR_Full)
> > +#define SUPPORTED_10000baseR_FEC     __ETHTOOL_LINK_MODE_LEGACY_
> MASK(10000baseR_FEC)
> > +#define SUPPORTED_20000baseMLD2_Full __ETHTOOL_LINK_MODE_LEGACY_
> MASK(20000baseMLD2_Full)
> > +#define SUPPORTED_20000baseKR2_Full  __ETHTOOL_LINK_MODE_LEGACY_
> MASK(20000baseKR2_Full)
> > +#define SUPPORTED_40000baseKR4_Full  __ETHTOOL_LINK_MODE_LEGACY_
> MASK(40000baseKR4_Full)
> > +#define SUPPORTED_40000baseCR4_Full  __ETHTOOL_LINK_MODE_LEGACY_
> MASK(40000baseCR4_Full)
> > +#define SUPPORTED_40000baseSR4_Full  __ETHTOOL_LINK_MODE_LEGACY_
> MASK(40000baseSR4_Full)
> > +#define SUPPORTED_40000baseLR4_Full  __ETHTOOL_LINK_MODE_LEGACY_
> MASK(40000baseLR4_Full)
> > +#define SUPPORTED_56000baseKR4_Full  __ETHTOOL_LINK_MODE_LEGACY_
> MASK(56000baseKR4_Full)
> > +#define SUPPORTED_56000baseCR4_Full  __ETHTOOL_LINK_MODE_LEGACY_
> MASK(56000baseCR4_Full)
> > +#define SUPPORTED_56000baseSR4_Full  __ETHTOOL_LINK_MODE_LEGACY_
> MASK(56000baseSR4_Full)
> > +#define SUPPORTED_56000baseLR4_Full  __ETHTOOL_LINK_MODE_LEGACY_
> MASK(56000baseLR4_Full)
> > +/* Please do not define any new SUPPORTED_* macro for bits > 31, see
> > + * notice above.
> > + */
> > +
> > +/*
> > + * DEPRECATED macros. Please migrate to
> > + * ETHTOOL_GLINKSETTINGS/ETHTOOL_SLINKSETTINGS API. Please do NOT
> > + * define any new ADERTISE_* macro for bits > 31.
> > + */
> > +#define ADVERTISED_10baseT_Half              __ETHTOOL_LINK_MODE_LEGACY_
> MASK(10baseT_Half)
> > +#define ADVERTISED_10baseT_Full              __ETHTOOL_LINK_MODE_LEGACY_
> MASK(10baseT_Full)
> > +#define ADVERTISED_100baseT_Half     __ETHTOOL_LINK_MODE_LEGACY_
> MASK(100baseT_Half)
> > +#define ADVERTISED_100baseT_Full     __ETHTOOL_LINK_MODE_LEGACY_
> MASK(100baseT_Full)
> > +#define ADVERTISED_1000baseT_Half    __ETHTOOL_LINK_MODE_LEGACY_
> MASK(1000baseT_Half)
> > +#define ADVERTISED_1000baseT_Full    __ETHTOOL_LINK_MODE_LEGACY_
> MASK(1000baseT_Full)
> > +#define ADVERTISED_Autoneg           __ETHTOOL_LINK_MODE_LEGACY_
> MASK(Autoneg)
> > +#define ADVERTISED_TP                        __ETHTOOL_LINK_MODE_LEGACY_
> MASK(TP)
> > +#define ADVERTISED_AUI                       __ETHTOOL_LINK_MODE_LEGACY_
> MASK(AUI)
> > +#define ADVERTISED_MII                       __ETHTOOL_LINK_MODE_LEGACY_
> MASK(MII)
> > +#define ADVERTISED_FIBRE             __ETHTOOL_LINK_MODE_LEGACY_
> MASK(FIBRE)
> > +#define ADVERTISED_BNC                       __ETHTOOL_LINK_MODE_LEGACY_
> MASK(BNC)
> > +#define ADVERTISED_10000baseT_Full   __ETHTOOL_LINK_MODE_LEGACY_
> MASK(10000baseT_Full)
> > +#define ADVERTISED_Pause             __ETHTOOL_LINK_MODE_LEGACY_
> MASK(Pause)
> > +#define ADVERTISED_Asym_Pause                __ETHTOOL_LINK_MODE_LEGACY_
> MASK(Asym_Pause)
> > +#define ADVERTISED_2500baseX_Full    __ETHTOOL_LINK_MODE_LEGACY_
> MASK(2500baseX_Full)
> > +#define ADVERTISED_Backplane         __ETHTOOL_LINK_MODE_LEGACY_
> MASK(Backplane)
> > +#define ADVERTISED_1000baseKX_Full   __ETHTOOL_LINK_MODE_LEGACY_
> MASK(1000baseKX_Full)
> > +#define ADVERTISED_10000baseKX4_Full __ETHTOOL_LINK_MODE_LEGACY_
> MASK(10000baseKX4_Full)
> > +#define ADVERTISED_10000baseKR_Full  __ETHTOOL_LINK_MODE_LEGACY_
> MASK(10000baseKR_Full)
> > +#define ADVERTISED_10000baseR_FEC    __ETHTOOL_LINK_MODE_LEGACY_
> MASK(10000baseR_FEC)
> > +#define ADVERTISED_20000baseMLD2_Full        __ETHTOOL_LINK_MODE_LEGACY_
> MASK(20000baseMLD2_Full)
> > +#define ADVERTISED_20000baseKR2_Full __ETHTOOL_LINK_MODE_LEGACY_
> MASK(20000baseKR2_Full)
> > +#define ADVERTISED_40000baseKR4_Full __ETHTOOL_LINK_MODE_LEGACY_
> MASK(40000baseKR4_Full)
> > +#define ADVERTISED_40000baseCR4_Full __ETHTOOL_LINK_MODE_LEGACY_
> MASK(40000baseCR4_Full)
> > +#define ADVERTISED_40000baseSR4_Full __ETHTOOL_LINK_MODE_LEGACY_
> MASK(40000baseSR4_Full)
> > +#define ADVERTISED_40000baseLR4_Full __ETHTOOL_LINK_MODE_LEGACY_
> MASK(40000baseLR4_Full)
> > +#define ADVERTISED_56000baseKR4_Full __ETHTOOL_LINK_MODE_LEGACY_
> MASK(56000baseKR4_Full)
> > +#define ADVERTISED_56000baseCR4_Full __ETHTOOL_LINK_MODE_LEGACY_
> MASK(56000baseCR4_Full)
> > +#define ADVERTISED_56000baseSR4_Full __ETHTOOL_LINK_MODE_LEGACY_
> MASK(56000baseSR4_Full)
> > +#define ADVERTISED_56000baseLR4_Full __ETHTOOL_LINK_MODE_LEGACY_
> MASK(56000baseLR4_Full)
> > +/* Please do not define any new ADVERTISED_* macro for bits > 31, see
> > + * notice above.
> > + */
> > +
> > +/* The following are all involved in forcing a particular link
> > + * mode for the device for setting things.  When getting the
> > + * devices settings, these indicate the current mode and whether
> > + * it was forced up into this mode or autonegotiated.
> > + */
> > +
> > +/* The forced speed, in units of 1Mb. All values 0 to INT_MAX are legal.
> > + * Update drivers/net/phy/phy.c:phy_speed_to_str() and
> > + * drivers/net/bonding/bond_3ad.c:__get_link_speed() when adding new
> values.
> > + */
> > +#define SPEED_10             10
> > +#define SPEED_100            100
> > +#define SPEED_1000           1000
> > +#define SPEED_2500           2500
> > +#define SPEED_5000           5000
> > +#define SPEED_10000          10000
> > +#define SPEED_14000          14000
> > +#define SPEED_20000          20000
> > +#define SPEED_25000          25000
> > +#define SPEED_40000          40000
> > +#define SPEED_50000          50000
> > +#define SPEED_56000          56000
> > +#define SPEED_100000         100000
> > +
> > +#define SPEED_UNKNOWN                -1
> > +
> > +static inline int ethtool_validate_speed(uint32_t speed)
> > +{
> > +     return speed <= INT_MAX || speed == SPEED_UNKNOWN;
> > +}
> > +
> > +/* Duplex, half or full. */
> > +#define DUPLEX_HALF          0x00
> > +#define DUPLEX_FULL          0x01
> > +#define DUPLEX_UNKNOWN               0xff
> > +
> > +static inline int ethtool_validate_duplex(uint8_t duplex)
> > +{
> > +     switch (duplex) {
> > +     case DUPLEX_HALF:
> > +     case DUPLEX_FULL:
> > +     case DUPLEX_UNKNOWN:
> > +             return 1;
> > +     }
> > +
> > +     return 0;
> > +}
> > +
> > +/* Which connector port. */
> > +#define PORT_TP                      0x00
> > +#define PORT_AUI             0x01
> > +#define PORT_MII             0x02
> > +#define PORT_FIBRE           0x03
> > +#define PORT_BNC             0x04
> > +#define PORT_DA                      0x05
> > +#define PORT_NONE            0xef
> > +#define PORT_OTHER           0xff
> > +
> > +/* Which transceiver to use. */
> > +#define XCVR_INTERNAL                0x00 /* PHY and MAC are in the
> same package */
> > +#define XCVR_EXTERNAL                0x01 /* PHY and MAC are in
> different packages */
> > +#define XCVR_DUMMY1          0x02
> > +#define XCVR_DUMMY2          0x03
> > +#define XCVR_DUMMY3          0x04
> > +
> > +/* Enable or disable autonegotiation. */
> > +#define AUTONEG_DISABLE              0x00
> > +#define AUTONEG_ENABLE               0x01
> > +
> > +/* MDI or MDI-X status/control - if MDI/MDI_X/AUTO is set then
> > + * the driver is required to renegotiate link
> > + */
> > +#define ETH_TP_MDI_INVALID   0x00 /* status: unknown; control:
> unsupported */
> > +#define ETH_TP_MDI           0x01 /* status: MDI;     control: force
> MDI */
> > +#define ETH_TP_MDI_X         0x02 /* status: MDI-X;   control: force
> MDI-X */
> > +#define ETH_TP_MDI_AUTO              0x03 /*                  control:
> auto-select */
> > +
> > +/* Wake-On-Lan options. */
> > +#define WAKE_PHY             (1 << 0)
> > +#define WAKE_UCAST           (1 << 1)
> > +#define WAKE_MCAST           (1 << 2)
> > +#define WAKE_BCAST           (1 << 3)
> > +#define WAKE_ARP             (1 << 4)
> > +#define WAKE_MAGIC           (1 << 5)
> > +#define WAKE_MAGICSECURE     (1 << 6) /* only meaningful if WAKE_MAGIC
> */
> > +
> > +/* L2-L4 network traffic flow types */
> > +#define      TCP_V4_FLOW     0x01    /* hash or spec (tcp_ip4_spec) */
> > +#define      UDP_V4_FLOW     0x02    /* hash or spec (udp_ip4_spec) */
> > +#define      SCTP_V4_FLOW    0x03    /* hash or spec (sctp_ip4_spec) */
> > +#define      AH_ESP_V4_FLOW  0x04    /* hash only */
> > +#define      TCP_V6_FLOW     0x05    /* hash or spec (tcp_ip6_spec; nfc
> only) */
> > +#define      UDP_V6_FLOW     0x06    /* hash or spec (udp_ip6_spec; nfc
> only) */
> > +#define      SCTP_V6_FLOW    0x07    /* hash or spec (sctp_ip6_spec;
> nfc only) */
> > +#define      AH_ESP_V6_FLOW  0x08    /* hash only */
> > +#define      AH_V4_FLOW      0x09    /* hash or spec (ah_ip4_spec) */
> > +#define      ESP_V4_FLOW     0x0a    /* hash or spec (esp_ip4_spec) */
> > +#define      AH_V6_FLOW      0x0b    /* hash or spec (ah_ip6_spec; nfc
> only) */
> > +#define      ESP_V6_FLOW     0x0c    /* hash or spec (esp_ip6_spec; nfc
> only) */
> > +#define      IPV4_USER_FLOW  0x0d    /* spec only (usr_ip4_spec) */
> > +#define      IP_USER_FLOW    IPV4_USER_FLOW
> > +#define      IPV6_USER_FLOW  0x0e    /* spec only (usr_ip6_spec; nfc
> only) */
> > +#define      IPV4_FLOW       0x10    /* hash only */
> > +#define      IPV6_FLOW       0x11    /* hash only */
> > +#define      ETHER_FLOW      0x12    /* spec only (ether_spec) */
> > +/* Flag to enable additional fields in struct ethtool_rx_flow_spec */
> > +#define      FLOW_EXT        0x80000000
> > +#define      FLOW_MAC_EXT    0x40000000
> > +
> > +/* L3-L4 network traffic flow hash options */
> > +#define      RXH_L2DA        (1 << 1)
> > +#define      RXH_VLAN        (1 << 2)
> > +#define      RXH_L3_PROTO    (1 << 3)
> > +#define      RXH_IP_SRC      (1 << 4)
> > +#define      RXH_IP_DST      (1 << 5)
> > +#define      RXH_L4_B_0_1    (1 << 6) /* src port in case of
> TCP/UDP/SCTP */
> > +#define      RXH_L4_B_2_3    (1 << 7) /* dst port in case of
> TCP/UDP/SCTP */
> > +#define      RXH_DISCARD     (1 << 31)
> > +
> > +#define      RX_CLS_FLOW_DISC        0xffffffffffffffffULL
> > +
> > +/* Special RX classification rule insert location values */
> > +#define RX_CLS_LOC_SPECIAL   0x80000000      /* flag */
> > +#define RX_CLS_LOC_ANY               0xffffffff
> > +#define RX_CLS_LOC_FIRST     0xfffffffe
> > +#define RX_CLS_LOC_LAST              0xfffffffd
> > +
> > +/* EEPROM Standards for plug in modules */
> > +#define ETH_MODULE_SFF_8079          0x1
> > +#define ETH_MODULE_SFF_8079_LEN              256
> > +#define ETH_MODULE_SFF_8472          0x2
> > +#define ETH_MODULE_SFF_8472_LEN              512
> > +#define ETH_MODULE_SFF_8636          0x3
> > +#define ETH_MODULE_SFF_8636_LEN              256
> > +#define ETH_MODULE_SFF_8436          0x4
> > +#define ETH_MODULE_SFF_8436_LEN              256
> > +
> > +/* Reset flags */
> > +/* The reset() operation must clear the flags for the components which
> > + * were actually reset.  On successful return, the flags indicate the
> > + * components which were not reset, either because they do not exist
> > + * in the hardware or because they cannot be reset independently.  The
> > + * driver must never reset any components that were not requested.
> > + */
> > +enum ethtool_reset_flags {
> > +     /* These flags represent components dedicated to the interface
> > +      * the command is addressed to.  Shift any flag left by
> > +      * ETH_RESET_SHARED_SHIFT to reset a shared component of the
> > +      * same type.
> > +      */
> > +     ETH_RESET_MGMT          = 1 << 0,       /* Management processor */
> > +     ETH_RESET_IRQ           = 1 << 1,       /* Interrupt requester */
> > +     ETH_RESET_DMA           = 1 << 2,       /* DMA engine */
> > +     ETH_RESET_FILTER        = 1 << 3,       /* Filtering/flow
> direction */
> > +     ETH_RESET_OFFLOAD       = 1 << 4,       /* Protocol offload */
> > +     ETH_RESET_MAC           = 1 << 5,       /* Media access controller
> */
> > +     ETH_RESET_PHY           = 1 << 6,       /* Transceiver/PHY */
> > +     ETH_RESET_RAM           = 1 << 7,       /* RAM shared between
> > +                                              * multiple components */
> > +     ETH_RESET_AP            = 1 << 8,       /* Application processor */
> > +
> > +     ETH_RESET_DEDICATED     = 0x0000ffff,   /* All components
> dedicated to
> > +                                              * this interface */
> > +     ETH_RESET_ALL           = 0xffffffff,   /* All components used by
> this
> > +                                              * interface, even if
> shared */
> > +};
> > +#define ETH_RESET_SHARED_SHIFT       16
> > +
> > +
> > +/**
> > + * struct ethtool_link_settings - link control and status
> > + *
> > + * IMPORTANT, Backward compatibility notice: When implementing new
> > + *   user-space tools, please first try %ETHTOOL_GLINKSETTINGS, and
> > + *   if it succeeds use %ETHTOOL_SLINKSETTINGS to change link
> > + *   settings; do not use %ETHTOOL_SSET if %ETHTOOL_GLINKSETTINGS
> > + *   succeeded: stick to %ETHTOOL_GLINKSETTINGS/%SLINKSETTINGS in
> > + *   that case.  Conversely, if %ETHTOOL_GLINKSETTINGS fails, use
> > + *   %ETHTOOL_GSET to query and %ETHTOOL_SSET to change link
> > + *   settings; do not use %ETHTOOL_SLINKSETTINGS if
> > + *   %ETHTOOL_GLINKSETTINGS failed: stick to
> > + *   %ETHTOOL_GSET/%ETHTOOL_SSET in that case.
> > + *
> > + * @cmd: Command number = %ETHTOOL_GLINKSETTINGS or
> %ETHTOOL_SLINKSETTINGS
> > + * @speed: Link speed (Mbps)
> > + * @duplex: Duplex mode; one of %DUPLEX_*
> > + * @port: Physical connector type; one of %PORT_*
> > + * @phy_address: MDIO address of PHY (transceiver); 0 or 255 if not
> > + *   applicable.  For clause 45 PHYs this is the PRTAD.
> > + * @autoneg: Enable/disable autonegotiation and auto-detection;
> > + *   either %AUTONEG_DISABLE or %AUTONEG_ENABLE
> > + * @mdio_support: Bitmask of %ETH_MDIO_SUPPORTS_* flags for the MDIO
> > + *   protocols supported by the interface; 0 if unknown.
> > + *   Read-only.
> > + * @eth_tp_mdix: Ethernet twisted-pair MDI(-X) status; one of
> > + *   %ETH_TP_MDI_*.  If the status is unknown or not applicable, the
> > + *   value will be %ETH_TP_MDI_INVALID.  Read-only.
> > + * @eth_tp_mdix_ctrl: Ethernet twisted pair MDI(-X) control; one of
> > + *   %ETH_TP_MDI_*.  If MDI(-X) control is not implemented, reads
> > + *   yield %ETH_TP_MDI_INVALID and writes may be ignored or rejected.
> > + *   When written successfully, the link should be renegotiated if
> > + *   necessary.
> > + * @link_mode_masks_nwords: Number of 32-bit words for each of the
> > + *   supported, advertising, lp_advertising link mode bitmaps. For
> > + *   %ETHTOOL_GLINKSETTINGS: on entry, number of words passed by user
> > + *   (>= 0); on return, if handshake in progress, negative if
> > + *   request size unsupported by kernel: absolute value indicates
> > + *   kernel expected size and all the other fields but cmd
> > + *   are 0; otherwise (handshake completed), strictly positive
> > + *   to indicate size used by kernel and cmd field stays
> > + *   %ETHTOOL_GLINKSETTINGS, all other fields populated by driver. For
> > + *   %ETHTOOL_SLINKSETTINGS: must be valid on entry, ie. a positive
> > + *   value returned previously by %ETHTOOL_GLINKSETTINGS, otherwise
> > + *   refused. For drivers: ignore this field (use kernel's
> > + *   __ETHTOOL_LINK_MODE_MASK_NBITS instead), any change to it will
> > + *   be overwritten by kernel.
> > + * @supported: Bitmap with each bit meaning given by
> > + *   %ethtool_link_mode_bit_indices for the link modes, physical
> > + *   connectors and other link features for which the interface
> > + *   supports autonegotiation or auto-detection.  Read-only.
> > + * @advertising: Bitmap with each bit meaning given by
> > + *   %ethtool_link_mode_bit_indices for the link modes, physical
> > + *   connectors and other link features that are advertised through
> > + *   autonegotiation or enabled for auto-detection.
> > + * @lp_advertising: Bitmap with each bit meaning given by
> > + *   %ethtool_link_mode_bit_indices for the link modes, and other
> > + *   link features that the link partner advertised through
> > + *   autonegotiation; 0 if unknown or not applicable.  Read-only.
> > + * @transceiver: Used to distinguish different possible PHY types,
> > + *   reported consistently by PHYLIB.  Read-only.
> > + *
> > + * If autonegotiation is disabled, the speed and @duplex represent the
> > + * fixed link mode and are writable if the driver supports multiple
> > + * link modes.  If it is enabled then they are read-only; if the link
> > + * is up they represent the negotiated link mode; if the link is down,
> > + * the speed is 0, %SPEED_UNKNOWN or the highest enabled speed and
> > + * @duplex is %DUPLEX_UNKNOWN or the best enabled duplex mode.
> > + *
> > + * Some hardware interfaces may have multiple PHYs and/or physical
> > + * connectors fitted or do not allow the driver to detect which are
> > + * fitted.  For these interfaces @port and/or @phy_address may be
> > + * writable, possibly dependent on @autoneg being %AUTONEG_DISABLE.
> > + * Otherwise, attempts to write different values may be ignored or
> > + * rejected.
> > + *
> > + * Deprecated %ethtool_cmd fields transceiver, maxtxpkt and maxrxpkt
> > + * are not available in %ethtool_link_settings. Until all drivers are
> > + * converted to ignore them or to the new %ethtool_link_settings API,
> > + * for both queries and changes, users should always try
> > + * %ETHTOOL_GLINKSETTINGS first, and if it fails with -ENOTSUPP stick
> > + * only to %ETHTOOL_GSET and %ETHTOOL_SSET consistently. If it
> > + * succeeds, then users should stick to %ETHTOOL_GLINKSETTINGS and
> > + * %ETHTOOL_SLINKSETTINGS (which would support drivers implementing
> > + * either %ethtool_cmd or %ethtool_link_settings).
> > + *
> > + * Users should assume that all fields not marked read-only are
> > + * writable and subject to validation by the driver.  They should use
> > + * %ETHTOOL_GLINKSETTINGS to get the current values before making
> specific
> > + * changes and then applying them with %ETHTOOL_SLINKSETTINGS.
> > + *
> > + * Drivers that implement %get_link_ksettings and/or
> > + * %set_link_ksettings should ignore the @cmd
> > + * and @link_mode_masks_nwords fields (any change to them overwritten
> > + * by kernel), and rely only on kernel's internal
> > + * %__ETHTOOL_LINK_MODE_MASK_NBITS and
> > + * %ethtool_link_mode_mask_t. Drivers that implement
> > + * %set_link_ksettings() should validate all fields other than @cmd
> > + * and @link_mode_masks_nwords that are not described as read-only or
> > + * deprecated, and must ignore all fields described as read-only.
> > + */
> > +struct ethtool_link_settings {
> > +     uint32_t        cmd;
> > +     uint32_t        speed;
> > +     uint8_t duplex;
> > +     uint8_t port;
> > +     uint8_t phy_address;
> > +     uint8_t autoneg;
> > +     uint8_t mdio_support;
> > +     uint8_t eth_tp_mdix;
> > +     uint8_t eth_tp_mdix_ctrl;
> > +     int8_t  link_mode_masks_nwords;
> > +     uint8_t transceiver;
> > +     uint8_t reserved1[3];
> > +     uint32_t        reserved[7];
> > +     uint32_t        link_mode_masks[0];
> > +     /* layout of link_mode_masks fields:
> > +      * uint32_t map_supported[link_mode_masks_nwords];
> > +      * uint32_t map_advertising[link_mode_masks_nwords];
> > +      * uint32_t map_lp_advertising[link_mode_masks_nwords];
> > +      */
> > +};
> > +#endif /* _LINUX_ETHTOOL_H */
> > diff --git a/include/standard-headers/linux/input.h
> b/include/standard-headers/linux/input.h
> > index 939b627..6d6128c 100644
> > --- a/include/standard-headers/linux/input.h
> > +++ b/include/standard-headers/linux/input.h
> > @@ -28,8 +28,8 @@ struct input_event {
> >  #define input_event_sec time.tv_sec
> >  #define input_event_usec time.tv_usec
> >  #else
> > -     __kernel_ulong_t __sec;
> > -     __kernel_ulong_t __usec;
> > +     unsigned long __sec;
> > +     unsigned long __usec;
> >  #define input_event_sec  __sec
> >  #define input_event_usec __usec
> >  #endif
> > diff --git a/include/standard-headers/linux/kernel.h
> b/include/standard-headers/linux/kernel.h
> > new file mode 100644
> > index 0000000..1eeba2e
> > --- /dev/null
> > +++ b/include/standard-headers/linux/kernel.h
> > @@ -0,0 +1,15 @@
> > +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> > +#ifndef _LINUX_KERNEL_H
> > +#define _LINUX_KERNEL_H
> > +
> > +#include "standard-headers/linux/sysinfo.h"
> > +
> > +/*
> > + * 'kernel.h' contains some often-used function prototypes etc
> > + */
> > +#define __ALIGN_KERNEL(x, a)         __ALIGN_KERNEL_MASK(x,
> (typeof(x))(a) - 1)
> > +#define __ALIGN_KERNEL_MASK(x, mask) (((x) + (mask)) & ~(mask))
> > +
> > +#define __KERNEL_DIV_ROUND_UP(n, d) (((n) + (d) - 1) / (d))
> > +
> > +#endif /* _LINUX_KERNEL_H */
> > diff --git a/include/standard-headers/linux/sysinfo.h
> b/include/standard-headers/linux/sysinfo.h
> > new file mode 100644
> > index 0000000..e3c06ac
> > --- /dev/null
> > +++ b/include/standard-headers/linux/sysinfo.h
> > @@ -0,0 +1,25 @@
> > +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> > +#ifndef _LINUX_SYSINFO_H
> > +#define _LINUX_SYSINFO_H
> > +
> > +#include "standard-headers/linux/types.h"
> > +
> > +#define SI_LOAD_SHIFT        16
> > +struct sysinfo {
> > +     long uptime;            /* Seconds since boot */
> > +     unsigned long loads[3]; /* 1, 5, and 15 minute load averages */
> > +     unsigned long totalram; /* Total usable main memory size */
> > +     unsigned long freeram;  /* Available memory size */
> > +     unsigned long sharedram;        /* Amount of shared memory */
> > +     unsigned long bufferram;        /* Memory used by buffers */
> > +     unsigned long totalswap;        /* Total swap space size */
> > +     unsigned long freeswap; /* swap space still available */
> > +     uint16_t procs;                 /* Number of current processes */
> > +     uint16_t pad;                   /* Explicit padding for m68k */
> > +     unsigned long totalhigh;        /* Total high memory size */
> > +     unsigned long freehigh; /* Available high memory size */
> > +     uint32_t mem_unit;                      /* Memory unit size in
> bytes */
> > +     char _f[20-2*sizeof(unsigned long)-sizeof(uint32_t)];   /*
> Padding: libc5 uses this.. */
> > +};
> > +
> > +#endif /* _LINUX_SYSINFO_H */
> > diff --git a/linux-headers/asm-x86/kvm_para.h
> b/linux-headers/asm-x86/kvm_para.h
> > index dc1ae08..4c58184 100644
> > --- a/linux-headers/asm-x86/kvm_para.h
> > +++ b/linux-headers/asm-x86/kvm_para.h
> > @@ -26,6 +26,7 @@
> >  #define KVM_FEATURE_PV_EOI           6
> >  #define KVM_FEATURE_PV_UNHALT                7
> >  #define KVM_FEATURE_PV_TLB_FLUSH     9
> > +#define KVM_FEATURE_ASYNC_PF_VMEXIT  10
> >
> >  /* The last 8 bits are used to indicate how to interpret the flags field
> >   * in pvclock structure. If no bits are set, all flags are ignored.
> > diff --git a/linux-headers/linux/kvm.h b/linux-headers/linux/kvm.h
> > index aed2230..a167be8 100644
> > --- a/linux-headers/linux/kvm.h
> > +++ b/linux-headers/linux/kvm.h
> > @@ -761,6 +761,7 @@ struct kvm_ppc_resize_hpt {
> >  #define KVM_TRACE_PAUSE           __KVM_DEPRECATED_MAIN_0x07
> >  #define KVM_TRACE_DISABLE         __KVM_DEPRECATED_MAIN_0x08
> >  #define KVM_GET_EMULATED_CPUID         _IOWR(KVMIO, 0x09, struct
> kvm_cpuid2)
> > +#define KVM_GET_MSR_FEATURE_INDEX_LIST    _IOWR(KVMIO, 0x0a, struct
> kvm_msr_list)
> >
> >  /*
> >   * Extension capability list.
> > @@ -934,6 +935,7 @@ struct kvm_ppc_resize_hpt {
> >  #define KVM_CAP_S390_AIS_MIGRATION 150
> >  #define KVM_CAP_PPC_GET_CPU_CHAR 151
> >  #define KVM_CAP_S390_BPB 152
> > +#define KVM_CAP_GET_MSR_FEATURES 153
> >
> >  #ifdef KVM_CAP_IRQ_ROUTING
> >
> > diff --git a/scripts/update-linux-headers.sh b/scripts/update-linux-
> headers.sh
> > index 9767172..849ba84 100755
> > --- a/scripts/update-linux-headers.sh
> > +++ b/scripts/update-linux-headers.sh
> > @@ -39,6 +39,9 @@ cp_portable() {
> >                                       -e 'input-event-codes' \
> >                                       -e 'sys/' \
> >                                       -e 'pvrdma_verbs' \
> > +                                     -e 'limits' \
> > +                                     -e 'linux/kernel' \
> > +                                     -e 'linux/sysinfo' \
> >                                       > /dev/null
> >      then
> >          echo "Unexpected #include in input file $f".
> > @@ -60,6 +63,10 @@ cp_portable() {
> >          -e '/sys\/ioctl.h/d' \
> >          -e 's/SW_MAX/SW_MAX_/' \
> >          -e 's/atomic_t/int/' \
> > +        -e 's/__kernel_long_t/long/' \
> > +        -e 's/__kernel_ulong_t/unsigned long/' \
> > +        -e 's/struct ethhdr/struct eth_header/' \
> > +        -e '/\#define _LINUX_ETHTOOL_H/a \\n\#include "net/eth.h"' \
> >          "$f" > "$to/$header";
> >  }
> >
> > @@ -149,7 +156,9 @@ rm -rf "$output/include/standard-headers/linux"
> >  mkdir -p "$output/include/standard-headers/linux"
> >  for i in "$tmpdir"/include/linux/*virtio*.h
> "$tmpdir/include/linux/input.h" \
> >           "$tmpdir/include/linux/input-event-codes.h" \
> > -         "$tmpdir/include/linux/pci_regs.h"; do
> > +         "$tmpdir/include/linux/pci_regs.h" \
> > +         "$tmpdir/include/linux/ethtool.h"
> "$tmpdir/include/linux/kernel.h" \
> > +         "$tmpdir/include/linux/sysinfo.h"; do
> >      cp_portable "$i" "$output/include/standard-headers/linux"
> >  done
> >
> > --
> > 2.7.4
>
> On Wed, Mar 07, 2018 at 10:25:40PM -0500, Jason Baron wrote:
> > In prepartion for using some of the high order feature bits, make sure
> that
> > virtio-net uses 64-bit values everywhere.
> >
> > Signed-off-by: Jason Baron <jbaron@akamai.com>
> > Cc: "Michael S. Tsirkin" <mst@redhat.com>
> > Cc: Jason Wang <jasowang@redhat.com>
> > Cc: virtio-dev@lists.oasis-open.org
> > ---
> >  hw/net/virtio-net.c            | 55 +++++++++++++++++++++---------
> ------------
> >  include/hw/virtio/virtio-net.h |  2 +-
> >  2 files changed, 29 insertions(+), 28 deletions(-)
> >
> > diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
> > index 369d40b..4feaa49 100644
> > --- a/hw/net/virtio-net.c
> > +++ b/hw/net/virtio-net.c
> > @@ -48,18 +48,18 @@
> >      (offsetof(container, field) + sizeof(((container *)0)->field))
> >
> >  typedef struct VirtIOFeature {
> > -    uint32_t flags;
> > +    uint64_t flags;
> >      size_t end;
> >  } VirtIOFeature;
> >
> >  static VirtIOFeature feature_sizes[] = {
> > -    {.flags = 1 << VIRTIO_NET_F_MAC,
> > +    {.flags = 1ULL << VIRTIO_NET_F_MAC,
> >       .end = endof(struct virtio_net_config, mac)},
> > -    {.flags = 1 << VIRTIO_NET_F_STATUS,
> > +    {.flags = 1ULL << VIRTIO_NET_F_STATUS,
> >       .end = endof(struct virtio_net_config, status)},
> > -    {.flags = 1 << VIRTIO_NET_F_MQ,
> > +    {.flags = 1ULL << VIRTIO_NET_F_MQ,
> >       .end = endof(struct virtio_net_config, max_virtqueue_pairs)},
> > -    {.flags = 1 << VIRTIO_NET_F_MTU,
> > +    {.flags = 1ULL << VIRTIO_NET_F_MTU,
> >       .end = endof(struct virtio_net_config, mtu)},
> >      {}
> >  };
> > @@ -1938,7 +1938,7 @@ static void virtio_net_device_realize(DeviceState
> *dev, Error **errp)
> >      int i;
> >
> >      if (n->net_conf.mtu) {
> > -        n->host_features |= (0x1 << VIRTIO_NET_F_MTU);
> > +        n->host_features |= (1ULL << VIRTIO_NET_F_MTU);
> >      }
> >
> >      virtio_net_set_config_size(n, n->host_features);
> > @@ -2109,45 +2109,46 @@ static const VMStateDescription
> vmstate_virtio_net = {
> >  };
> >
> >  static Property virtio_net_properties[] = {
> > -    DEFINE_PROP_BIT("csum", VirtIONet, host_features,
> VIRTIO_NET_F_CSUM, true),
> > -    DEFINE_PROP_BIT("guest_csum", VirtIONet, host_features,
> > +    DEFINE_PROP_BIT64("csum", VirtIONet, host_features,
> > +                    VIRTIO_NET_F_CSUM, true),
> > +    DEFINE_PROP_BIT64("guest_csum", VirtIONet, host_features,
> >                      VIRTIO_NET_F_GUEST_CSUM, true),
> > -    DEFINE_PROP_BIT("gso", VirtIONet, host_features, VIRTIO_NET_F_GSO,
> true),
> > -    DEFINE_PROP_BIT("guest_tso4", VirtIONet, host_features,
> > +    DEFINE_PROP_BIT64("gso", VirtIONet, host_features,
> VIRTIO_NET_F_GSO, true),
> > +    DEFINE_PROP_BIT64("guest_tso4", VirtIONet, host_features,
> >                      VIRTIO_NET_F_GUEST_TSO4, true),
> > -    DEFINE_PROP_BIT("guest_tso6", VirtIONet, host_features,
> > +    DEFINE_PROP_BIT64("guest_tso6", VirtIONet, host_features,
> >                      VIRTIO_NET_F_GUEST_TSO6, true),
> > -    DEFINE_PROP_BIT("guest_ecn", VirtIONet, host_features,
> > +    DEFINE_PROP_BIT64("guest_ecn", VirtIONet, host_features,
> >                      VIRTIO_NET_F_GUEST_ECN, true),
> > -    DEFINE_PROP_BIT("guest_ufo", VirtIONet, host_features,
> > +    DEFINE_PROP_BIT64("guest_ufo", VirtIONet, host_features,
> >                      VIRTIO_NET_F_GUEST_UFO, true),
> > -    DEFINE_PROP_BIT("guest_announce", VirtIONet, host_features,
> > +    DEFINE_PROP_BIT64("guest_announce", VirtIONet, host_features,
> >                      VIRTIO_NET_F_GUEST_ANNOUNCE, true),
> > -    DEFINE_PROP_BIT("host_tso4", VirtIONet, host_features,
> > +    DEFINE_PROP_BIT64("host_tso4", VirtIONet, host_features,
> >                      VIRTIO_NET_F_HOST_TSO4, true),
> > -    DEFINE_PROP_BIT("host_tso6", VirtIONet, host_features,
> > +    DEFINE_PROP_BIT64("host_tso6", VirtIONet, host_features,
> >                      VIRTIO_NET_F_HOST_TSO6, true),
> > -    DEFINE_PROP_BIT("host_ecn", VirtIONet, host_features,
> > +    DEFINE_PROP_BIT64("host_ecn", VirtIONet, host_features,
> >                      VIRTIO_NET_F_HOST_ECN, true),
> > -    DEFINE_PROP_BIT("host_ufo", VirtIONet, host_features,
> > +    DEFINE_PROP_BIT64("host_ufo", VirtIONet, host_features,
> >                      VIRTIO_NET_F_HOST_UFO, true),
> > -    DEFINE_PROP_BIT("mrg_rxbuf", VirtIONet, host_features,
> > +    DEFINE_PROP_BIT64("mrg_rxbuf", VirtIONet, host_features,
> >                      VIRTIO_NET_F_MRG_RXBUF, true),
> > -    DEFINE_PROP_BIT("status", VirtIONet, host_features,
> > +    DEFINE_PROP_BIT64("status", VirtIONet, host_features,
> >                      VIRTIO_NET_F_STATUS, true),
> > -    DEFINE_PROP_BIT("ctrl_vq", VirtIONet, host_features,
> > +    DEFINE_PROP_BIT64("ctrl_vq", VirtIONet, host_features,
> >                      VIRTIO_NET_F_CTRL_VQ, true),
> > -    DEFINE_PROP_BIT("ctrl_rx", VirtIONet, host_features,
> > +    DEFINE_PROP_BIT64("ctrl_rx", VirtIONet, host_features,
> >                      VIRTIO_NET_F_CTRL_RX, true),
> > -    DEFINE_PROP_BIT("ctrl_vlan", VirtIONet, host_features,
> > +    DEFINE_PROP_BIT64("ctrl_vlan", VirtIONet, host_features,
> >                      VIRTIO_NET_F_CTRL_VLAN, true),
> > -    DEFINE_PROP_BIT("ctrl_rx_extra", VirtIONet, host_features,
> > +    DEFINE_PROP_BIT64("ctrl_rx_extra", VirtIONet, host_features,
> >                      VIRTIO_NET_F_CTRL_RX_EXTRA, true),
> > -    DEFINE_PROP_BIT("ctrl_mac_addr", VirtIONet, host_features,
> > +    DEFINE_PROP_BIT64("ctrl_mac_addr", VirtIONet, host_features,
> >                      VIRTIO_NET_F_CTRL_MAC_ADDR, true),
> > -    DEFINE_PROP_BIT("ctrl_guest_offloads", VirtIONet, host_features,
> > +    DEFINE_PROP_BIT64("ctrl_guest_offloads", VirtIONet, host_features,
> >                      VIRTIO_NET_F_CTRL_GUEST_OFFLOADS, true),
> > -    DEFINE_PROP_BIT("mq", VirtIONet, host_features, VIRTIO_NET_F_MQ,
> false),
> > +    DEFINE_PROP_BIT64("mq", VirtIONet, host_features, VIRTIO_NET_F_MQ,
> false),
> >      DEFINE_NIC_PROPERTIES(VirtIONet, nic_conf),
> >      DEFINE_PROP_UINT32("x-txtimer", VirtIONet, net_conf.txtimer,
> >                         TX_TIMER_INTERVAL),
> > diff --git a/include/hw/virtio/virtio-net.h b/include/hw/virtio/virtio-
> net.h
> > index b81b6a4..e7634c9 100644
> > --- a/include/hw/virtio/virtio-net.h
> > +++ b/include/hw/virtio/virtio-net.h
> > @@ -67,7 +67,7 @@ typedef struct VirtIONet {
> >      uint32_t has_vnet_hdr;
> >      size_t host_hdr_len;
> >      size_t guest_hdr_len;
> > -    uint32_t host_features;
> > +    uint64_t host_features;
> >      uint8_t has_ufo;
> >      uint32_t mergeable_rx_bufs;
> >      uint8_t promisc;
> > --
> > 2.7.4
>
> On Wed, Mar 07, 2018 at 10:25:41PM -0500, Jason Baron wrote:
> > Although linkspeed and duplex can be set in a linux guest via 'ethtool
> -s',
> > this requires custom ethtool commands for virtio-net by default.
> >
> > Introduce a new feature flag, VIRTIO_NET_F_SPEED_DUPLEX, which allows
> > the hypervisor to export a linkspeed and duplex setting. The user can
> > subsequently overwrite it later if desired via: 'ethtool -s'.
> >
> > Linkspeed and duplex settings can be set as:
> > '-device virtio-net,speed=10000,duplex=full'
> >
> > where speed is [0...INT_MAX], and duplex is ["half"|"full"].
> >
> > Signed-off-by: Jason Baron <jbaron@akamai.com>
> > Cc: "Michael S. Tsirkin" <mst@redhat.com>
> > Cc: Jason Wang <jasowang@redhat.com>
> > Cc: virtio-dev@lists.oasis-open.org
> > ---
> >  hw/net/virtio-net.c            | 26 ++++++++++++++++++++++++++
> >  include/hw/virtio/virtio-net.h |  3 +++
> >  2 files changed, 29 insertions(+)
> >
> > diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
> > index 4feaa49..c3ce7d2 100644
> > --- a/hw/net/virtio-net.c
> > +++ b/hw/net/virtio-net.c
> > @@ -26,6 +26,7 @@
> >  #include "qapi-event.h"
> >  #include "hw/virtio/virtio-access.h"
> >  #include "migration/misc.h"
> > +#include "standard-headers/linux/ethtool.h"
> >
> >  #define VIRTIO_NET_VM_VERSION    11
> >
> > @@ -61,6 +62,8 @@ static VirtIOFeature feature_sizes[] = {
> >       .end = endof(struct virtio_net_config, max_virtqueue_pairs)},
> >      {.flags = 1ULL << VIRTIO_NET_F_MTU,
> >       .end = endof(struct virtio_net_config, mtu)},
> > +    {.flags = 1ULL << VIRTIO_NET_F_SPEED_DUPLEX,
> > +     .end = endof(struct virtio_net_config, duplex)},
> >      {}
> >  };
> >
> > @@ -89,6 +92,8 @@ static void virtio_net_get_config(VirtIODevice *vdev,
> uint8_t *config)
> >      virtio_stw_p(vdev, &netcfg.max_virtqueue_pairs, n->max_queues);
> >      virtio_stw_p(vdev, &netcfg.mtu, n->net_conf.mtu);
> >      memcpy(netcfg.mac, n->mac, ETH_ALEN);
> > +    virtio_stl_p(vdev, &netcfg.speed, n->net_conf.speed);
> > +    netcfg.duplex = n->net_conf.duplex;
> >      memcpy(config, &netcfg, n->config_size);
> >  }
> >
> > @@ -1941,6 +1946,25 @@ static void virtio_net_device_realize(DeviceState
> *dev, Error **errp)
> >          n->host_features |= (1ULL << VIRTIO_NET_F_MTU);
> >      }
> >
> > +    if (n->net_conf.duplex_str) {
> > +        if (strncmp(n->net_conf.duplex_str, "half", 5) == 0) {
> > +            n->net_conf.duplex = DUPLEX_HALF;
> > +        } else if (strncmp(n->net_conf.duplex_str, "full", 5) == 0) {
> > +            n->net_conf.duplex = DUPLEX_FULL;
> > +        } else {
> > +            error_setg(errp, "'duplex' must be 'half' or 'full'");
> > +        }
> > +        n->host_features |= (1ULL << VIRTIO_NET_F_SPEED_DUPLEX);
> > +    } else {
> > +        n->net_conf.duplex = DUPLEX_UNKNOWN;
> > +    }
> > +
> > +    if (n->net_conf.speed < SPEED_UNKNOWN) {
> > +        error_setg(errp, "'speed' must be between 0 and INT_MAX");
> > +    } else if (n->net_conf.speed >= 0) {
> > +        n->host_features |= (1ULL << VIRTIO_NET_F_SPEED_DUPLEX);
> > +    }
> > +
> >      virtio_net_set_config_size(n, n->host_features);
> >      virtio_init(vdev, "virtio-net", VIRTIO_ID_NET, n->config_size);
> >
> > @@ -2161,6 +2185,8 @@ static Property virtio_net_properties[] = {
> >      DEFINE_PROP_UINT16("host_mtu", VirtIONet, net_conf.mtu, 0),
> >      DEFINE_PROP_BOOL("x-mtu-bypass-backend", VirtIONet,
> mtu_bypass_backend,
> >                       true),
> > +    DEFINE_PROP_INT32("speed", VirtIONet, net_conf.speed,
> SPEED_UNKNOWN),
> > +    DEFINE_PROP_STRING("duplex", VirtIONet, net_conf.duplex_str),
> >      DEFINE_PROP_END_OF_LIST(),
> >  };
> >
> > diff --git a/include/hw/virtio/virtio-net.h b/include/hw/virtio/virtio-
> net.h
> > index e7634c9..02484dc 100644
> > --- a/include/hw/virtio/virtio-net.h
> > +++ b/include/hw/virtio/virtio-net.h
> > @@ -38,6 +38,9 @@ typedef struct virtio_net_conf
> >      uint16_t rx_queue_size;
> >      uint16_t tx_queue_size;
> >      uint16_t mtu;
> > +    int32_t speed;
> > +    char *duplex_str;
> > +    uint8_t duplex;
> >  } virtio_net_conf;
> >
> >  /* Maximum packet size we can receive from tap device: header + 64k */
> > --
> > 2.7.4
>
>
>
>
> ------------------------------
>
> Subject: Digest Footer
>
> _______________________________________________
> Qemu-devel mailing list
> Qemu-devel@nongnu.org
> https://lists.nongnu.org/mailman/listinfo/qemu-devel
>
>
> ------------------------------
>
> End of Qemu-devel Digest, Vol 180, Issue 211
> ********************************************
>
