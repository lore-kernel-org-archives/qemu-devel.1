Received: from eggs.gnu.org ([2001:4830:134:3::10]:35037)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1dxLIn-0007dI-Th
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 18:59:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1dxLIm-0007WQ-G5
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 18:59:38 -0400
MIME-Version: 1.0
Sender: alistair23@gmail.com
In-Reply-To: <1788278d-9437-34a0-4a17-d7914d459f77@redhat.com>
References: <cover.1506384414.git.alistair.francis@xilinx.com>
	<e9eb34b7a508fbe3b89bb8b8aa8141f018871081.1506384414.git.alistair.francis@xilinx.com>
	<1788278d-9437-34a0-4a17-d7914d459f77@redhat.com>
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Wed, 27 Sep 2017 15:59:04 -0700
Message-ID: <CAKmqyKMzdmNJ=+pHNa8fq7MPq+KCn_BtKEzoD99qw9=KE2ZqVw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v1 1/8] Replace all occurances of
 __FUNCTION__ with __func__
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Alistair Francis <alistair.francis@xilinx.com>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Stefano Stabellini <sstabellini@kernel.org>, Fam Zheng <famz@redhat.com>, qemu-block@nongnu.org, Peter Crosthwaite <crosthwaite.peter@gmail.com>, John Snow <jsnow@redhat.com>, Juan Quintela <quintela@redhat.com>, Markus Armbruster <armbru@redhat.com>, Yongbok Kim <yongbok.kim@imgtec.com>, qemu-arm <qemu-arm@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, "open list:X86" <xen-devel@lists.xenproject.org>, Anthony Perard <anthony.perard@citrix.com>, Aurelien Jarno <aurelien@aurel32.net>

On Tue, Sep 26, 2017 at 6:32 AM, Eric Blake <eblake@redhat.com> wrote:
> On 09/25/2017 07:08 PM, Alistair Francis wrote:
>> Replace all occurs of __FUNCTION__ except for the check in checkpatch
>> with the non GCC specific __func__.
>>
>> One line in hcd-musb.c was manually tweaked to pass checkpatch.
>>
>> Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
>> Cc: Gerd Hoffmann <kraxel@redhat.com>
>> Cc: Andrzej Zaborowski <balrogg@gmail.com>
>> Cc: Stefano Stabellini <sstabellini@kernel.org>
>> Cc: Anthony Perard <anthony.perard@citrix.com>
>> Cc: John Snow <jsnow@redhat.com>
>> Cc: Aurelien Jarno <aurelien@aurel32.net>
>> Cc: Yongbok Kim <yongbok.kim@imgtec.com>
>> Cc: Peter Crosthwaite <crosthwaite.peter@gmail.com>
>> Cc: Stefan Hajnoczi <stefanha@redhat.com> (supporter:Block
>> Cc: Fam Zheng <famz@redhat.com> (supporter:Block
>
> That looks funny, with no closing ).  Something's breaking down between
> get_maintainers.pl and your eventual email, although it's not fatal.

Yeah, that's a copy and paste error, will fix.

>
>> Cc: Juan Quintela <quintela@redhat.com>
>> Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>> Cc: qemu-arm@nongnu.org
>> Cc: qemu-block@nongnu.org
>> Cc: xen-devel@lists.xenproject.org
>> ---
>>
>
>>  65 files changed, 273 insertions(+), 273 deletions(-)
>
> Big but mechanical, so I'm okay without splitting it further.

Phew! I did not want to split it.

>
>>
>> diff --git a/audio/audio_int.h b/audio/audio_int.h
>> index 5bcb1c60e1..543b1bd8d5 100644
>> --- a/audio/audio_int.h
>> +++ b/audio/audio_int.h
>> @@ -253,7 +253,7 @@ static inline int audio_ring_dist (int dst, int src, int len)
>>  #define AUDIO_STRINGIFY(n) AUDIO_STRINGIFY_(n)
>>
>>  #if defined _MSC_VER || defined __GNUC__
>> -#define AUDIO_FUNC __FUNCTION__
>> +#define AUDIO_FUNC __func__
>>  #else
>>  #define AUDIO_FUNC __FILE__ ":" AUDIO_STRINGIFY (__LINE__)
>>  #endif
>
> This can be further simplified.  We really aren't using _MSC_VER as our
> compiler (can anyone prove me wrong?), and we DO require a C99 compiler
> (per C99 6.4.2.2, __func__ support is mandatory), so we don't really
> need the #else branch (or, for that matter, we probably don't even need
> AUDIO_FUNC).  But to keep this patch mechanical, that can be a separate
> followup.

I have a second patch that removes AUDIO_FUNC

>
>> diff --git a/hw/arm/nseries.c b/hw/arm/nseries.c
>> index 58005b6619..32687afced 100644
>> --- a/hw/arm/nseries.c
>> +++ b/hw/arm/nseries.c
>> @@ -463,7 +463,7 @@ static uint32_t mipid_txrx(void *opaque, uint32_t cmd, int len)
>>      uint8_t ret;
>>
>>      if (len > 9) {
>> -        hw_error("%s: FIXME: bad SPI word width %i\n", __FUNCTION__, len);
>> +        hw_error("%s: FIXME: bad SPI word width %i\n", __func__, len);
>
> Not this patch's problem, but it would probably be simpler if hw_error()
> were a macro that automatically prefixed __func__, rather than making
> every caller have to supply it themselves.

I'm going to leave this for another day, but I think you are right.

>
>> +++ b/hw/arm/omap1.c
>
>> @@ -1716,7 +1716,7 @@ static void omap_clkm_write(void *opaque, hwaddr addr,
>>      case 0x18:       /* ARM_SYSST */
>>          if ((s->clkm.clocking_scheme ^ (value >> 11)) & 7) {
>>              s->clkm.clocking_scheme = (value >> 11) & 7;
>> -            printf("%s: clocking scheme set to %s\n", __FUNCTION__,
>> +            printf("%s: clocking scheme set to %s\n", __func__,
>>                              clkschemename[s->clkm.clocking_scheme]);
>
> Worth fixing the indentation while you are here?

Fixed

>
>> @@ -2473,7 +2473,7 @@ static void omap_pwt_write(void *opaque, hwaddr addr,
>>      case 0x04:       /* VRC */
>>          if ((value ^ s->vrc) & 1) {
>>              if (value & 1)
>> -                printf("%s: %iHz buzz on\n", __FUNCTION__, (int)
>> +                printf("%s: %iHz buzz on\n", __func__, (int)
>>                                  /* 1.5 MHz from a 12-MHz or 13-MHz PWT_CLK */
>>                                  ((omap_clk_getrate(s->clk) >> 3) /
>>                                   /* Pre-multiplexer divider */
>
> Likewise?

This doesn't actually change the indention. It's all one argument to a function.

>
>> @@ -3330,13 +3330,13 @@ static void omap_mcbsp_writeh(void *opaque, hwaddr addr,
>>          s->mcr[1] = value & 0x03e3;
>>          if (value & 3)                                       /* XMCM */
>>              printf("%s: Tx channel selection mode enable attempt\n",
>> -                            __FUNCTION__);
>> +                            __func__);
>>          return;
>>      case 0x1a:       /* MCR1 */
>>          s->mcr[0] = value & 0x03e1;
>>          if (value & 1)                                       /* RMCM */
>>              printf("%s: Rx channel selection mode enable attempt\n",
>> -                            __FUNCTION__);
>> +                            __func__);
>
> and again

Fixed.

>
>
>> +++ b/hw/arm/omap2.c
>> @@ -1312,7 +1312,7 @@ static void omap_prcm_apll_update(struct omap_prcm_s *s)
>>
>>      if (mode[0] == 1 || mode[0] == 2 || mode[1] == 1 || mode[1] == 2)
>>          fprintf(stderr, "%s: bad EN_54M_PLL or bad EN_96M_PLL\n",
>> -                        __FUNCTION__);
>> +                        __func__);
>
> More of the same. I'll quit pointing it out.

Fixed

>
>
>> +++ b/hw/block/onenand.c
>> @@ -661,12 +661,12 @@ static uint64_t onenand_read(void *opaque, hwaddr addr,
>>      case 0xff02:     /* ECC Result of spare area data */
>>      case 0xff03:     /* ECC Result of main area data */
>>      case 0xff04:     /* ECC Result of spare area data */
>> -        hw_error("%s: imeplement ECC\n", __FUNCTION__);
>> +        hw_error("%s: imeplement ECC\n", __func__);
>
> Should we fix the typo while here? s/imeplement/implement/

Fixed

>
>> +++ b/hw/isa/vt82c686.c
>> @@ -30,7 +30,7 @@
>>  //#define DEBUG_VT82C686B
>>
>>  #ifdef DEBUG_VT82C686B
>> -#define DPRINTF(fmt, ...) fprintf(stderr, "%s: " fmt, __FUNCTION__, ##__VA_ARGS__)
>> +#define DPRINTF(fmt, ...) fprintf(stderr, "%s: " fmt, __func__, ##__VA_ARGS__)
>>  #else
>>  #define DPRINTF(fmt, ...)
>>  #endif
>
> Not this patch's problem, but I hate bit-rottable statements.  This
> should be fixed separately into a form that always evaluates under
> -Wformat (guarded by an if(0) in normal builds).

Ah, I really don't want to go down that rabbit hole right now either.
I might leave this as is.

>
>> diff --git a/hw/mips/gt64xxx_pci.c b/hw/mips/gt64xxx_pci.c
>> index e8b2eef688..41a7690560 100644
>> --- a/hw/mips/gt64xxx_pci.c
>> +++ b/hw/mips/gt64xxx_pci.c
>> @@ -33,7 +33,7 @@
>>  //#define DEBUG
>>
>>  #ifdef DEBUG
>> -#define DPRINTF(fmt, ...) fprintf(stderr, "%s: " fmt, __FUNCTION__, ##__VA_ARGS__)
>> +#define DPRINTF(fmt, ...) fprintf(stderr, "%s: " fmt, __func__, ##__VA_ARGS__)
>>  #else
>>  #define DPRINTF(fmt, ...)
>>  #endif
>
> Ditto.
>
>
>> +++ b/hw/usb/hcd-musb.c
>> @@ -253,8 +253,8 @@
>>  /* #define MUSB_DEBUG */
>>
>>  #ifdef MUSB_DEBUG
>> -#define TRACE(fmt,...) fprintf(stderr, "%s@%d: " fmt "\n", __FUNCTION__, \
>> -                               __LINE__, ##__VA_ARGS__)
>> +#define TRACE(fmt, ...) fprintf(stderr, "%s@%d: " fmt "\n", __func__, \
>> +                                __LINE__, ##__VA_ARGS__)
>>  #else
>>  #define TRACE(...)
>>  #endif
>
> and again
>
> My comments were either about things for separate patches, or things
> that are trivial if you choose to touch them up, so:
>
> Reviewed-by: Eric Blake <eblake@redhat.com>

Thanks!

Alistair

>
> --
> Eric Blake, Principal Software Engineer
> Red Hat, Inc.           +1-919-301-3266
> Virtualization:  qemu.org | libvirt.org
>
