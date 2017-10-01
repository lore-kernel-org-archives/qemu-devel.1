Received: from eggs.gnu.org ([2001:4830:134:3::10]:60253)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dyTBZ-0004GC-JE
	for qemu-devel@nongnu.org; Sat, 30 Sep 2017 21:36:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dyTBV-000257-VN
	for qemu-devel@nongnu.org; Sat, 30 Sep 2017 21:36:49 -0400
Received: from mail-qt0-x244.google.com ([2607:f8b0:400d:c0d::244]:47679)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dyTBV-00022e-PK
	for qemu-devel@nongnu.org; Sat, 30 Sep 2017 21:36:45 -0400
Received: by mail-qt0-x244.google.com with SMTP id b1so3706702qtc.4
	for <qemu-devel@nongnu.org>; Sat, 30 Sep 2017 18:36:43 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <cover.1506730372.git.alistair.francis@xilinx.com>
	<06e443b5be5198646e9f76b80df198e954543daf.1506730372.git.alistair.francis@xilinx.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <9008446b-d889-d9ce-4cc8-545e17ecbbbe@amsat.org>
Date: Sat, 30 Sep 2017 22:36:36 -0300
MIME-Version: 1.0
In-Reply-To: <06e443b5be5198646e9f76b80df198e954543daf.1506730372.git.alistair.francis@xilinx.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 40/47] hw/usb: Replace fprintf(stderr,
 "*\n" with error_report()
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>, qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Gerd Hoffmann <kraxel@redhat.com>, armbru@redhat.com
List-ID: <qemu-devel.nongnu.org>

On 09/29/2017 09:17 PM, Alistair Francis wrote:
> Replace a large number of the fprintf(stderr, "*\n" calls with
> error_report(). The functions were renamed with these commands and then
> compiler issues where manually fixed.
> 
> find ./* -type f -exec sed -i \
>      'N;N;N;N;N;N;N;N;N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
>      {} +
> find ./* -type f -exec sed -i \
>      'N;N;N;N;N;N;N;N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
>      {} +
> find ./* -type f -exec sed -i \
>      'N;N;N;N;N;N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
>      {} +
> find ./* -type f -exec sed -i \
>      'N;N;N;N;N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
>      {} +
> find ./* -type f -exec sed -i \
>      'N;N;N;N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
>      {} +
> find ./* -type f -exec sed -i \
>      'N;N;N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
>      {} +
> find ./* -type f -exec sed -i \
>      'N;N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
>      {} +
> find ./* -type f -exec sed -i \
>      'N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
>      {} +
> find ./* -type f -exec sed -i \
>      'N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
>      {} +
> find ./* -type f -exec sed -i \
>      'N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
>      {} +
> find ./* -type f -exec sed -i \
>      'N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
>      {} +
> 
> Some lines where then manually tweaked to pass checkpatch.
> 
> Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
> Cc: Gerd Hoffmann <kraxel@redhat.com>
> ---
> V2:
>   - Split hw patch into individual directories
> 
>   hw/usb/core.c          | 15 ++++++++-------
>   hw/usb/desc.c          |  4 ++--
>   hw/usb/dev-audio.c     | 29 +++++++++++++++--------------
>   hw/usb/dev-bluetooth.c |  4 ++--
>   hw/usb/dev-mtp.c       |  9 +++++----
>   hw/usb/dev-network.c   | 20 ++++++++++----------
>   hw/usb/hcd-ehci.c      | 32 ++++++++++++++++----------------
>   hw/usb/hcd-musb.c      |  4 ++--
>   hw/usb/hcd-xhci.c      |  3 ++-
>   hw/usb/host-legacy.c   |  2 +-
>   10 files changed, 63 insertions(+), 59 deletions(-)
> 
> diff --git a/hw/usb/core.c b/hw/usb/core.c
> index 241ae66b15..9ffdef055c 100644
> --- a/hw/usb/core.c
> +++ b/hw/usb/core.c
> @@ -24,6 +24,7 @@
>    * THE SOFTWARE.
>    */
>   #include "qemu/osdep.h"
> +#include "qemu/error-report.h"
>   #include "qemu-common.h"
>   #include "hw/usb.h"
>   #include "qemu/iov.h"
> @@ -599,7 +600,7 @@ void usb_packet_copy(USBPacket *p, void *ptr, size_t bytes)
>           iov_from_buf(iov->iov, iov->niov, p->actual_length, ptr, bytes);
>           break;
>       default:
> -        fprintf(stderr, "%s: invalid pid: %x\n", __func__, p->pid);
> +        error_report("%s: invalid pid: %x", __func__, p->pid);
>           abort();
>       }
>       p->actual_length += bytes;
> @@ -681,7 +682,7 @@ void usb_ep_dump(USBDevice *dev)
>       };
>       int ifnum, ep, first;
>   
> -    fprintf(stderr, "Device \"%s\", config %d\n",
> +    error_report("Device \"%s\", config %d",
>               dev->product_desc, dev->configuration);
>       for (ifnum = 0; ifnum < 16; ifnum++) {
>           first = 1;
> @@ -690,10 +691,10 @@ void usb_ep_dump(USBDevice *dev)
>                   dev->ep_in[ep].ifnum == ifnum) {
>                   if (first) {
>                       first = 0;
> -                    fprintf(stderr, "  Interface %d, alternative %d\n",
> +                    error_report("  Interface %d, alternative %d",
>                               ifnum, dev->altsetting[ifnum]);
>                   }
> -                fprintf(stderr, "    Endpoint %d, IN, %s, %d max\n", ep,
> +                error_report("    Endpoint %d, IN, %s, %d max", ep,
>                           tname[dev->ep_in[ep].type],
>                           dev->ep_in[ep].max_packet_size);
>               }
> @@ -701,16 +702,16 @@ void usb_ep_dump(USBDevice *dev)
>                   dev->ep_out[ep].ifnum == ifnum) {
>                   if (first) {
>                       first = 0;
> -                    fprintf(stderr, "  Interface %d, alternative %d\n",
> +                    error_report("  Interface %d, alternative %d",
>                               ifnum, dev->altsetting[ifnum]);
>                   }
> -                fprintf(stderr, "    Endpoint %d, OUT, %s, %d max\n", ep,
> +                error_report("    Endpoint %d, OUT, %s, %d max", ep,
>                           tname[dev->ep_out[ep].type],
>                           dev->ep_out[ep].max_packet_size);
>               }
>           }
>       }
> -    fprintf(stderr, "--\n");
> +    error_report("--");
>   }
>   
>   struct USBEndpoint *usb_ep_get(USBDevice *dev, int pid, int ep)
> diff --git a/hw/usb/desc.c b/hw/usb/desc.c
> index 85c15addc5..afae910f8e 100644
> --- a/hw/usb/desc.c
> +++ b/hw/usb/desc.c
> @@ -1,5 +1,5 @@
>   #include "qemu/osdep.h"
> -
> +#include "qemu/error-report.h"
>   #include "hw/usb.h"
>   #include "hw/usb/desc.h"
>   #include "trace.h"
> @@ -688,7 +688,7 @@ int usb_desc_get_descriptor(USBDevice *dev, USBPacket *p,
>           break;
>   
>       default:
> -        fprintf(stderr, "%s: %d unknown type %d (len %zd)\n", __func__,
> +        error_report("%s: %d unknown type %d (len %zd)", __func__,
>                   dev->addr, type, len);
>           break;
>       }
> diff --git a/hw/usb/dev-audio.c b/hw/usb/dev-audio.c
> index 343345235c..43fc20469a 100644
> --- a/hw/usb/dev-audio.c
> +++ b/hw/usb/dev-audio.c
> @@ -30,6 +30,7 @@
>    */
>   
>   #include "qemu/osdep.h"
> +#include "qemu/error-report.h"
>   #include "qemu-common.h"
>   #include "hw/usb.h"
>   #include "hw/usb/desc.h"
> @@ -398,7 +399,7 @@ static int usb_audio_set_output_altset(USBAudioState *s, int altset)
>       }
>   
>       if (s->debug) {
> -        fprintf(stderr, "usb-audio: set interface %d\n", altset);
> +        error_report("usb-audio: set interface %d", altset);
>       }
>       s->out.altset = altset;
>       return 0;
> @@ -478,7 +479,7 @@ static int usb_audio_set_control(USBAudioState *s, uint8_t attrib,
>               uint16_t vol = data[0] + (data[1] << 8);
>   
>               if (s->debug) {
> -                fprintf(stderr, "usb-audio: vol %04x\n", (uint16_t)vol);
> +                error_report("usb-audio: vol %04x", (uint16_t)vol);
>               }
>   
>               vol -= 0x8000;
> @@ -496,7 +497,7 @@ static int usb_audio_set_control(USBAudioState *s, uint8_t attrib,
>   
>       if (set_vol) {
>           if (s->debug) {
> -            fprintf(stderr, "usb-audio: mute %d, lvol %3d, rvol %3d\n",
> +            error_report("usb-audio: mute %d, lvol %3d, rvol %3d",
>                       s->out.mute, s->out.vol[0], s->out.vol[1]);
>           }
>           AUD_set_volume_out(s->out.voice, s->out.mute,
> @@ -514,8 +515,8 @@ static void usb_audio_handle_control(USBDevice *dev, USBPacket *p,
>       int ret = 0;
>   
>       if (s->debug) {
> -        fprintf(stderr, "usb-audio: control transaction: "
> -                "request 0x%04x value 0x%04x index 0x%04x length 0x%04x\n",
> +        error_report("usb-audio: control transaction: "
> +                "request 0x%04x value 0x%04x index 0x%04x length 0x%04x",
>                   request, value, index, length);
>       }
>   
> @@ -533,7 +534,7 @@ static void usb_audio_handle_control(USBDevice *dev, USBPacket *p,
>                                       length, data);
>           if (ret < 0) {
>               if (s->debug) {
> -                fprintf(stderr, "usb-audio: fail: get control\n");
> +                error_report("usb-audio: fail: get control");
>               }
>               goto fail;
>           }
> @@ -548,7 +549,7 @@ static void usb_audio_handle_control(USBDevice *dev, USBPacket *p,
>                                       length, data);
>           if (ret < 0) {
>               if (s->debug) {
> -                fprintf(stderr, "usb-audio: fail: set control\n");
> +                error_report("usb-audio: fail: set control");
>               }
>               goto fail;
>           }
> @@ -557,8 +558,8 @@ static void usb_audio_handle_control(USBDevice *dev, USBPacket *p,
>       default:
>   fail:
>           if (s->debug) {
> -            fprintf(stderr, "usb-audio: failed control transaction: "
> -                    "request 0x%04x value 0x%04x index 0x%04x length 0x%04x\n",
> +            error_report("usb-audio: failed control transaction: "
> +                    "request 0x%04x value 0x%04x index 0x%04x length 0x%04x",
>                       request, value, index, length);
>           }
>           p->status = USB_RET_STALL;
> @@ -581,7 +582,7 @@ static void usb_audio_handle_reset(USBDevice *dev)
>       USBAudioState *s = USB_AUDIO(dev);
>   
>       if (s->debug) {
> -        fprintf(stderr, "usb-audio: reset\n");
> +        error_report("usb-audio: reset");
>       }
>       usb_audio_set_output_altset(s, ALTSET_OFF);
>   }
> @@ -595,7 +596,7 @@ static void usb_audio_handle_dataout(USBAudioState *s, USBPacket *p)
>   
>       streambuf_put(&s->out.buf, p);
>       if (p->actual_length < p->iov.size && s->debug > 1) {
> -        fprintf(stderr, "usb-audio: output overrun (%zd bytes)\n",
> +        error_report("usb-audio: output overrun (%zd bytes)",
>                   p->iov.size - p->actual_length);
>       }
>   }
> @@ -611,8 +612,8 @@ static void usb_audio_handle_data(USBDevice *dev, USBPacket *p)
>   
>       p->status = USB_RET_STALL;
>       if (s->debug) {
> -        fprintf(stderr, "usb-audio: failed data transaction: "
> -                        "pid 0x%x ep 0x%x len 0x%zx\n",
> +        error_report("usb-audio: failed data transaction: "
> +                        "pid 0x%x ep 0x%x len 0x%zx",
>                           p->pid, p->ep->nr, p->iov.size);
>       }
>   }
> @@ -622,7 +623,7 @@ static void usb_audio_unrealize(USBDevice *dev, Error **errp)
>       USBAudioState *s = USB_AUDIO(dev);
>   
>       if (s->debug) {
> -        fprintf(stderr, "usb-audio: destroy\n");
> +        error_report("usb-audio: destroy");
>       }
>   
>       usb_audio_set_output_altset(s, ALTSET_OFF);
> diff --git a/hw/usb/dev-bluetooth.c b/hw/usb/dev-bluetooth.c
> index 0bbceaea0b..dfef258dca 100644
> --- a/hw/usb/dev-bluetooth.c
> +++ b/hw/usb/dev-bluetooth.c
> @@ -274,13 +274,13 @@ static void usb_bt_fifo_enqueue(struct usb_hci_in_fifo_s *fifo,
>       if (off <= DFIFO_LEN_MASK) {
>           if (off + len > DFIFO_LEN_MASK + 1 &&
>                           (fifo->dsize = off + len) > (DFIFO_LEN_MASK + 1) * 2) {
> -            fprintf(stderr, "%s: can't alloc %i bytes\n", __func__, len);
> +            error_report("%s: can't alloc %i bytes", __func__, len);
>               exit(-1);
>           }
>           buf = fifo->data + off;
>       } else {
>           if (fifo->dlen > fifo->dsize) {
> -            fprintf(stderr, "%s: can't alloc %i bytes\n", __func__, len);
> +            error_report("%s: can't alloc %i bytes", __func__, len);
>               exit(-1);
>           }
>           buf = fifo->data + off - fifo->dsize;
> diff --git a/hw/usb/dev-mtp.c b/hw/usb/dev-mtp.c
> index 94c2e94f10..7e1782b8fc 100644
> --- a/hw/usb/dev-mtp.c
> +++ b/hw/usb/dev-mtp.c
> @@ -10,6 +10,7 @@
>    */
>   
>   #include "qemu/osdep.h"
> +#include "qemu/error-report.h"
>   #include "qapi/error.h"
>   #include <wchar.h>
>   #include <dirent.h>
> @@ -546,7 +547,7 @@ static void inotify_watchfn(void *arg)
>                   break;
>   
>               default:
> -                fprintf(stderr, "usb-mtp: failed to parse inotify event\n");
> +                error_report("usb-mtp: failed to parse inotify event");
>                   continue;
>               }
>   
> @@ -617,7 +618,7 @@ static void usb_mtp_object_readdir(MTPState *s, MTPObject *o)
>   #ifdef CONFIG_INOTIFY1
>       int watchfd = usb_mtp_add_watch(s->inotifyfd, o->path);
>       if (watchfd == -1) {
> -        fprintf(stderr, "usb-mtp: failed to add watch for %s\n", o->path);
> +        error_report("usb-mtp: failed to add watch for %s", o->path);
>       } else {
>           trace_usb_mtp_inotify_event(s->dev.addr, o->path,
>                                       0, "Watch Added");
> @@ -1144,7 +1145,7 @@ static void usb_mtp_command(MTPState *s, MTPControl *c)
>           usb_mtp_object_alloc(s, s->next_handle++, NULL, s->root);
>   #ifdef CONFIG_INOTIFY1
>           if (usb_mtp_inotify_init(s)) {
> -            fprintf(stderr, "usb-mtp: file monitoring init failed\n");
> +            error_report("usb-mtp: file monitoring init failed");
>           }
>   #endif
>           break;
> @@ -1348,7 +1349,7 @@ static void usb_mtp_handle_control(USBDevice *dev, USBPacket *p,
>   static void usb_mtp_cancel_packet(USBDevice *dev, USBPacket *p)
>   {
>       /* we don't use async packets, so this should never be called */
> -    fprintf(stderr, "%s\n", __func__);
> +    error_report("%s", __func__);

what about using tracepoint instead? this report is probably confusing 
instead of being useful for the user imho.

>   }
>   
>   static void usb_mtp_handle_data(USBDevice *dev, USBPacket *p)
> diff --git a/hw/usb/dev-network.c b/hw/usb/dev-network.c
> index 85fc81bf43..9dd4af5e34 100644
> --- a/hw/usb/dev-network.c
> +++ b/hw/usb/dev-network.c
> @@ -815,7 +815,7 @@ static int ndis_query(USBNetState *s, uint32_t oid,
>           return sizeof(le32);
>   
>       default:
> -        fprintf(stderr, "usbnet: unknown OID 0x%08x\n", oid);
> +        error_report("usbnet: unknown OID 0x%08x", oid);
>           return 0;
>       }
>       return -1;
> @@ -1084,9 +1084,9 @@ static void usb_net_handle_control(USBDevice *dev, USBPacket *p,
>               for (i = 0; i < length; i++) {
>                   if (!(i & 15))
>                       fprintf(stderr, "\n%04x:", i);
> -                fprintf(stderr, " %02x", data[i]);
> +                error_report(" %02x", data[i]);
>               }
> -            fprintf(stderr, "\n\n");
> +            fprintf(stderr, "\n");

eh?

>           }
>   #endif
>           ret = rndis_parse(s, data, length);
> @@ -1111,17 +1111,17 @@ static void usb_net_handle_control(USBDevice *dev, USBPacket *p,
>               for (i = 0; i < p->actual_length; i++) {
>                   if (!(i & 15))
>                       fprintf(stderr, "\n%04x:", i);
> -                fprintf(stderr, " %02x", data[i]);
> +                error_report(" %02x", data[i]);
>               }
> -            fprintf(stderr, "\n\n");
> +            fprintf(stderr, "\n");

eh?

>           }
>   #endif
>           break;
>   
>       default:
>       fail:
> -        fprintf(stderr, "usbnet: failed control transaction: "
> -                        "request 0x%x value 0x%x index 0x%x length 0x%x\n",
> +        error_report("usbnet: failed control transaction: "
> +                        "request 0x%x value 0x%x index 0x%x length 0x%x",
>                           request, value, index, length);
>           p->status = USB_RET_STALL;
>           break;
> @@ -1190,7 +1190,7 @@ static void usb_net_handle_dataout(USBNetState *s, USBPacket *p)
>       uint32_t len;
>   
>   #ifdef TRAFFIC_DEBUG
> -    fprintf(stderr, "usbnet: data out len %zu\n", p->iov.size);
> +    error_report("usbnet: data out len %zu", p->iov.size);
>       iov_hexdump(p->iov.iov, p->iov.niov, stderr, "usbnet", p->iov.size);
>   #endif
>   
> @@ -1260,8 +1260,8 @@ static void usb_net_handle_data(USBDevice *dev, USBPacket *p)
>       }
>   
>       if (p->status == USB_RET_STALL) {
> -        fprintf(stderr, "usbnet: failed data transaction: "
> -                        "pid 0x%x ep 0x%x len 0x%zx\n",
> +        error_report("usbnet: failed data transaction: "
> +                        "pid 0x%x ep 0x%x len 0x%zx",
>                           p->pid, p->ep->nr, p->iov.size);
>       }
>   }
> diff --git a/hw/usb/hcd-ehci.c b/hw/usb/hcd-ehci.c
> index 0134232627..e405b882fb 100644
> --- a/hw/usb/hcd-ehci.c
> +++ b/hw/usb/hcd-ehci.c
> @@ -419,7 +419,7 @@ static int ehci_get_pid(EHCIqtd *qtd)
>       case 2:
>           return USB_TOKEN_SETUP;
>       default:
> -        fprintf(stderr, "bad token\n");
> +        error_report("bad token");
>           return 0;
>       }
>   }
> @@ -1033,7 +1033,7 @@ static void ehci_opreg_write(void *ptr, hwaddr addr,
>   
>           /* not supporting dynamic frame list size at the moment */
>           if ((val & USBCMD_FLS) && !(s->usbcmd & USBCMD_FLS)) {
> -            fprintf(stderr, "attempt to set frame list size -- value %d\n",
> +            error_report("attempt to set frame list size -- value %d",
>                       (int)val & USBCMD_FLS);
>               val &= ~USBCMD_FLS;
>           }
> @@ -1190,7 +1190,7 @@ static int ehci_init_transfer(EHCIPacket *p)
>   
>       while (bytes > 0) {
>           if (cpage > 4) {
> -            fprintf(stderr, "cpage out of range (%d)\n", cpage);
> +            error_report("cpage out of range (%d)", cpage);
>               qemu_sglist_destroy(&p->sgl);
>               return -1;
>           }
> @@ -1296,7 +1296,7 @@ static void ehci_execute_complete(EHCIQueue *q)
>           break;
>       default:
>           /* should not be triggerable */
> -        fprintf(stderr, "USB invalid response %d\n", p->packet.status);
> +        error_report("USB invalid response %d", p->packet.status);
>           g_assert_not_reached();
>           break;
>       }
> @@ -1345,7 +1345,7 @@ static int ehci_execute(EHCIPacket *p, const char *action)
>              p->async == EHCI_ASYNC_INITIALIZED);
>   
>       if (!(p->qtd.token & QTD_TOKEN_ACTIVE)) {
> -        fprintf(stderr, "Attempting to execute inactive qtd\n");
> +        error_report("Attempting to execute inactive qtd");
>           return -1;
>       }
>   
> @@ -1383,7 +1383,7 @@ static int ehci_execute(EHCIPacket *p, const char *action)
>               p->packet.actual_length);
>   
>       if (p->packet.actual_length > BUFF_SIZE) {
> -        fprintf(stderr, "ret from usb_handle_packet > BUFF_SIZE\n");
> +        error_report("ret from usb_handle_packet > BUFF_SIZE");
>           return -1;
>       }
>   
> @@ -1461,7 +1461,7 @@ static int ehci_process_itd(EHCIState *ehci,
>               case USB_RET_SUCCESS:
>                   break;
>               default:
> -                fprintf(stderr, "Unexpected iso usb result: %d\n",
> +                error_report("Unexpected iso usb result: %d",
>                           ehci->ipacket.status);
>                   /* Fall through */
>               case USB_RET_IOERROR:
> @@ -1564,7 +1564,7 @@ static int ehci_state_fetchentry(EHCIState *ehci, int async)
>   
>       /* section 4.8, only QH in async schedule */
>       if (async && (NLPTR_TYPE_GET(entry) != NLPTR_TYPE_QH)) {
> -        fprintf(stderr, "non queue head request in async schedule\n");
> +        error_report("non queue head request in async schedule");
>           return -1;
>       }
>   
> @@ -1586,8 +1586,8 @@ static int ehci_state_fetchentry(EHCIState *ehci, int async)
>   
>       default:
>           /* TODO: handle FSTN type */
> -        fprintf(stderr, "FETCHENTRY: entry at %X is of type %d "
> -                "which is not supported yet\n", entry, NLPTR_TYPE_GET(entry));
> +        error_report("FETCHENTRY: entry at %X is of type %d "
> +                "which is not supported yet", entry, NLPTR_TYPE_GET(entry));
>           return -1;
>       }
>   
> @@ -2086,7 +2086,7 @@ static void ehci_advance_state(EHCIState *ehci, int async)
>               break;
>   
>           default:
> -            fprintf(stderr, "Bad state!\n");
> +            error_report("Bad state!");
>               again = -1;
>               g_assert_not_reached();
>               break;
> @@ -2094,7 +2094,7 @@ static void ehci_advance_state(EHCIState *ehci, int async)
>   
>           if (again < 0 || itd_count > 16) {
>               /* TODO: notify guest (raise HSE irq?) */
> -            fprintf(stderr, "processing error - resetting ehci HC\n");
> +            error_report("processing error - resetting ehci HC");
>               ehci_reset(ehci);
>               again = 0;
>           }
> @@ -2151,8 +2151,8 @@ static void ehci_advance_async_state(EHCIState *ehci)
>   
>       default:
>           /* this should only be due to a developer mistake */
> -        fprintf(stderr, "ehci: Bad asynchronous state %d. "
> -                "Resetting to active\n", ehci->astate);
> +        error_report("ehci: Bad asynchronous state %d. "
> +                "Resetting to active", ehci->astate);
>           g_assert_not_reached();
>       }
>   }
> @@ -2201,8 +2201,8 @@ static void ehci_advance_periodic_state(EHCIState *ehci)
>   
>       default:
>           /* this should only be due to a developer mistake */
> -        fprintf(stderr, "ehci: Bad periodic state %d. "
> -                "Resetting to active\n", ehci->pstate);
> +        error_report("ehci: Bad periodic state %d. "
> +                "Resetting to active", ehci->pstate);
>           g_assert_not_reached();
>       }
>   }
> diff --git a/hw/usb/hcd-musb.c b/hw/usb/hcd-musb.c
> index d70a91a58c..4729926124 100644
> --- a/hw/usb/hcd-musb.c
> +++ b/hw/usb/hcd-musb.c
> @@ -253,8 +253,8 @@
>   /* #define MUSB_DEBUG */
>   
>   #ifdef MUSB_DEBUG
> -#define TRACE(fmt, ...) fprintf(stderr, "%s@%d: " fmt "\n", __func__, \
> -                                __LINE__, ##__VA_ARGS__)
> +#define TRACE(fmt, ...) error_report("%s@%d: " fmt "", __func__, \
> +                                     __LINE__, ##__VA_ARGS__)
>   #else
>   #define TRACE(...)
>   #endif
> diff --git a/hw/usb/hcd-xhci.c b/hw/usb/hcd-xhci.c
> index d75c085d94..6cc1be09a2 100644
> --- a/hw/usb/hcd-xhci.c
> +++ b/hw/usb/hcd-xhci.c
> @@ -19,6 +19,7 @@
>    * License along with this library; if not, see <http://www.gnu.org/licenses/>.
>    */
>   #include "qemu/osdep.h"
> +#include "qemu/error-report.h"
>   #include "hw/hw.h"
>   #include "qemu/timer.h"
>   #include "qemu/queue.h"
> @@ -39,7 +40,7 @@
>   #else
>   #define DPRINTF(...) do {} while (0)
>   #endif
> -#define FIXME(_msg) do { fprintf(stderr, "FIXME %s:%d %s\n", \
> +#define FIXME(_msg) do { error_report("FIXME %s:%d %s", \
>                                    __func__, __LINE__, _msg); abort(); } while (0)
>   
>   #define TRB_LINK_LIMIT  32
> diff --git a/hw/usb/host-legacy.c b/hw/usb/host-legacy.c
> index 3b57e21b52..f0c81e5309 100644
> --- a/hw/usb/host-legacy.c
> +++ b/hw/usb/host-legacy.c
> @@ -86,7 +86,7 @@ static int parse_filter(const char *spec, struct USBAutoFilter *f)
>       }
>   
>       if (i < DEV) {
> -        fprintf(stderr, "husb: invalid auto filter spec %s\n", spec);
> +        error_report("husb: invalid auto filter spec %s", spec);
>           return -1;
>       }
>   
> 
