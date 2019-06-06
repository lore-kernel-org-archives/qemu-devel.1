Return-Path: <SRS0=9X/F=UF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75D0CC28D1E
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 09:56:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F30D92083E
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 09:56:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F30D92083E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:57522 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYp7p-0003s9-2e
	for qemu-devel@archiver.kernel.org; Thu, 06 Jun 2019 05:56:01 -0400
Received: from eggs.gnu.org ([209.51.188.92]:45375)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hYp6w-0003LR-M6
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 05:55:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hYp6v-0001wn-Hf
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 05:55:06 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:42881)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>)
	id 1hYp6q-0001fa-Mg; Thu, 06 Jun 2019 05:55:00 -0400
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
	(mreue009 [213.165.67.103]) with ESMTPSA (Nemesis) id
	1N6srH-1gUL9L1tbr-018OQU; Thu, 06 Jun 2019 11:54:32 +0200
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
	qemu-devel@nongnu.org, qemu-trivial@nongnu.org
References: <20190528164020.32250-1-philmd@redhat.com>
	<20190528164020.32250-3-philmd@redhat.com>
From: Laurent Vivier <laurent@vivier.eu>
Openpgp: preference=signencrypt
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
	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
Message-ID: <bc27395d-e3b6-b2c6-17f2-7cbfc82a3498@vivier.eu>
Date: Thu, 6 Jun 2019 11:54:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190528164020.32250-3-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:32l68PyGqgumeMJOnmhh5/nn6XfrZywbLGHDfNpgvVYdfc7+b8T
	yFFy7fePY0yJzcutG2D9C+Jyc1Xys7O68neCfj4++eGmWUdUffwpOnztDzhc0awnHNi4/+n
	KqS2RnsfXpaUbNEtXLuT0GVqu8kIRYA4dOmqTGzqpDdP23DcBGEKNe6wnpdjEUHiJyTKl9K
	v6/GZTvFyF1aLTprXJKLA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:gdxgAGouVqQ=:/rHYq0WA9XFfRPhUJPb1NS
	kgTXJdRcHo8rnXAjK+TM9MJpnl5ypQjZgTUD265zuUkK+w4zRVNhuwB+SqN79nH1oJFHhrMJq
	3KgtNUV0zIlE2RVZIlRL2taraosRQkyQwl3ov3PBGZiA0pTdYuEGWpq1+cDaxvLFd6mX4yD3B
	0petpEdLkqsN/HtOCccm8Ugy9yDsSEUHzUr24jYy2fgIMtzU6/DYISIzD/QCeXBFujcWKehjI
	598CtymccNY3mUWF/JfYgjyTcg7RGKTBqYS2rMwvOtISc25rMeegDR8oNAdGVlBnOhCLF5QXF
	wytY+UkP/AfySz+EX1yHUpQOopHW0+ZfBdzjJxbJ9IDrtFDeGnFbAB1ibAHxvB510Gad3Dz2E
	4ybotL3gYBBGxSA5mdonYhnh552czic0/gQOzu6YDcFRRlwHlFAT8RWsmZo+fb4lu5tmD3S3V
	j5UPYg16xywd8JOremEcc8TY/WHmkkqBJ4jSh+zx3pMwu6yBXBrbjjzFtnJhSLVcx5lyAWgt5
	nnJtwdxjHZCIAWbD0BEBnk4u6AuQwWS4XMSlwcv0vctcw7C3WjOKRJjijvpiL0LsQWoSvkkR0
	XA8buPI+s2UaSc3qchdMQlRFgIqk4tfAhGZ4SJjePhGrQ4tAhv8y+KhX4LzC62eRsm67XwSbU
	NFfBaR5BxMNG9MZtgICm3iHFWC/v2H4ZKbOsm3nm6hjqO1bgQlNrYQUgysLEu4YqAOYbIGH0f
	9wCiFMS7aqqlsXnOkwAyrxxNFK8gF90V1mG3hWu3PhvCB+VaTbdQCIWkSP8=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.126.187
Subject: Re: [Qemu-devel] [Qemu-trivial] [PATCH v2 02/10] hw/scsi: Use the
 QOM BUS() macro to access BusState.qbus
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
	Dmitry Fleytman <dmitry.fleytman@gmail.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Aleksandar Rikalo <arikalo@wavecomp.com>,
	David Hildenbrand <david@redhat.com>,
	Markus Armbruster <armbru@redhat.com>,
	Halil Pasic <pasic@linux.ibm.com>, qemu-s390x@nongnu.org,
	Alex Williamson <alex.williamson@redhat.com>,
	Michael Walle <michael@walle.cc>,
	Aleksandar Markovic <amarkovic@wavecomp.com>,
	Cornelia Huck <cohuck@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
	Richard Henderson <rth@twiddle.net>,
	Christian Borntraeger <borntraeger@de.ibm.com>,
	Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 28/05/2019 à 18:40, Philippe Mathieu-Daudé a écrit :
> Rather than looking inside the definition of a BusState with "s->bus.qbus",
> use the QOM prefered style: "BUS(&s->bus)".
> 
> This patch was generated using the following Coccinelle script:
> 
>     // Use BUS() macros to access BusState.qbus
>     @use_bus_macro_to_access_qbus@
>     expression obj;
>     identifier bus;
>     @@
>     -&obj->bus.qbus
>     +BUS(&obj->bus)
> 
> Suggested-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
>  hw/scsi/lsi53c895a.c  | 2 +-
>  hw/scsi/mptsas.c      | 4 ++--
>  hw/scsi/virtio-scsi.c | 2 +-
>  3 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/scsi/lsi53c895a.c b/hw/scsi/lsi53c895a.c
> index da7239d94f..a8b7a199f9 100644
> --- a/hw/scsi/lsi53c895a.c
> +++ b/hw/scsi/lsi53c895a.c
> @@ -1860,7 +1860,7 @@ static void lsi_reg_writeb(LSIState *s, int offset, uint8_t val)
>          }
>          if (val & LSI_SCNTL1_RST) {
>              if (!(s->sstat0 & LSI_SSTAT0_RST)) {
> -                qbus_reset_all(&s->bus.qbus);
> +                qbus_reset_all(BUS(&s->bus));
>                  s->sstat0 |= LSI_SSTAT0_RST;
>                  lsi_script_scsi_interrupt(s, LSI_SIST0_RST, 0);
>              }
> diff --git a/hw/scsi/mptsas.c b/hw/scsi/mptsas.c
> index 929404fb48..e800683e91 100644
> --- a/hw/scsi/mptsas.c
> +++ b/hw/scsi/mptsas.c
> @@ -540,7 +540,7 @@ reply_maybe_async:
>          break;
>  
>      case MPI_SCSITASKMGMT_TASKTYPE_RESET_BUS:
> -        qbus_reset_all(&s->bus.qbus);
> +        qbus_reset_all(BUS(&s->bus));
>          break;
>  
>      default:
> @@ -803,7 +803,7 @@ static void mptsas_soft_reset(MPTSASState *s)
>      s->intr_mask = MPI_HIM_DIM | MPI_HIM_RIM;
>      mptsas_update_interrupt(s);
>  
> -    qbus_reset_all(&s->bus.qbus);
> +    qbus_reset_all(BUS(&s->bus));
>      s->intr_status = 0;
>      s->intr_mask = save_mask;
>  
> diff --git a/hw/scsi/virtio-scsi.c b/hw/scsi/virtio-scsi.c
> index 839f120256..2a71b78e22 100644
> --- a/hw/scsi/virtio-scsi.c
> +++ b/hw/scsi/virtio-scsi.c
> @@ -696,7 +696,7 @@ static void virtio_scsi_reset(VirtIODevice *vdev)
>  
>      assert(!s->dataplane_started);
>      s->resetting++;
> -    qbus_reset_all(&s->bus.qbus);
> +    qbus_reset_all(BUS(&s->bus));
>      s->resetting--;
>  
>      vs->sense_size = VIRTIO_SCSI_SENSE_DEFAULT_SIZE;
> 

Applied to my trivial-patches branch.

Thanks,
Laurent

