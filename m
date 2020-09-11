Return-Path: <SRS0=/zFi=CU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CE7DC43461
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 07:33:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CCA2D21D91
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 07:33:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uKrR8aX/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCA2D21D91
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48812 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGdYR-00019u-NM
	for qemu-devel@archiver.kernel.org; Fri, 11 Sep 2020 03:33:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47698)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1kGdW9-0007X4-K0; Fri, 11 Sep 2020 03:30:45 -0400
Received: from mail-lj1-x244.google.com ([2a00:1450:4864:20::244]:45327)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1kGdW7-00023v-H5; Fri, 11 Sep 2020 03:30:45 -0400
Received: by mail-lj1-x244.google.com with SMTP id c2so11425538ljj.12;
 Fri, 11 Sep 2020 00:30:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to;
 bh=KbZAHRdaRJQ8981Lwfce3AQEq2/4upxkYnJ+uN/ll40=;
 b=uKrR8aX/1aNtRpopiBAQZ9Me5BRcLWipn02nMEguEBmZZ5GUnmMed6xbLfmHW2dhbA
 7ShKrJjQTdzkwsfJVjee1v7S98fhk3F4vKYc6Q2NYOVmxknoekH/NTGjhUuIvI/5qaue
 CkgRDUHUOjaG1VlHcB9Tk10P7RW/a2dLuLbIAJ6hrZTJNYbCqX8w86G9EviGJzE88s1i
 OkBmdxPBwh/PV84toi11LbAWpJ0zgxGNDY/KuvA8R7hN3duncMtHissjCyG7XkYLDFJ7
 lVBIyz+AR4aApAVD25jbA+ntCicwe5vCLWaJvdYKu1+b1lf5DpRDOTOjDIcl56k6SwYK
 Ppqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=KbZAHRdaRJQ8981Lwfce3AQEq2/4upxkYnJ+uN/ll40=;
 b=QKlbGcG+3G47cX2F05TDM7mhxlKroukZQAXM8dprx27TyxgnsfGPEwX4+y+q2dE2re
 54fiu0sCAHVzHd9kabWrN5vgg+cGxF0OmwHS5Uu+8szJZmWOVMmFRh6DrJFKtge13cY+
 jJnyzApm9Y6r1+KfOCx7WYl+gPJlrwvdREg3X4pd0s0ky3Py/4q9V8TpnigH9P168Uxk
 5oxb/yGafm0uyuV/PQ71TOnAopyLLksZjbOZ0/fA21yrTYWfDyQtaniQ5Da5rw+c06Bw
 Nz28qxvLy74mO/VpaIyUrhahn1o9TWe12zKTurbHApd9IzAty5Y77em6YCvU/VVrFvUF
 xRZQ==
X-Gm-Message-State: AOAM531MTGu8UDXro7AfmR2dkWK2yRuSwaj/+E5wOyQnk2P1DKPFMzDm
 M4/gM854Kkdu9zuopJXW5kI=
X-Google-Smtp-Source: ABdhPJz4g08Nul6UVQVSxFGB+mmajPiY8BktJEvs6ik/bEu35pcxfbBaTbd/QVGxf+oOYppAH0rYgA==
X-Received: by 2002:a2e:93cf:: with SMTP id p15mr300454ljh.244.1599809440262; 
 Fri, 11 Sep 2020 00:30:40 -0700 (PDT)
Received: from gmail.com (81-231-232-130-no39.tbcn.telia.com. [81.231.232.130])
 by smtp.gmail.com with ESMTPSA id v13sm300467lfo.30.2020.09.11.00.30.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Sep 2020 00:30:39 -0700 (PDT)
Date: Fri, 11 Sep 2020 09:30:39 +0200
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 2/6] hw/core/stream: Rename StreamSlave as StreamSink
Message-ID: <20200911073039.GC2954729@toto>
References: <20200910070131.435543-1-philmd@redhat.com>
 <20200910070131.435543-3-philmd@redhat.com>
 <cf510052-4059-b53b-fd86-5cfbbd6d95fb@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cf510052-4059-b53b-fd86-5cfbbd6d95fb@redhat.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::244;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-lj1-x244.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -2
X-Spam_score: -0.3
X-Spam_bar: /
X-Spam_report: (-0.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 FSL_HELO_FAKE=1.8, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Laurent Vivier <lvivier@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Alistair Francis <alistair@alistair23.me>,
 Eduardo Habkost <ehabkost@redhat.com>, kvm@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>, Andrew Jeffery <andrew@aj.id.au>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 qemu-devel@nongnu.org, Joel Stanley <joel@jms.id.au>, qemu-trivial@nongnu.org,
 qemu-arm@nongnu.org, =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Sep 11, 2020 at 09:28:16AM +0200, Paolo Bonzini wrote:
> On 10/09/20 09:01, Philippe Mathieu-Daudé wrote:
> > In order to use inclusive terminology, rename 'slave stream'
> > as 'sink stream'.
> > 
> > Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> 
> From Edgar Iglesias:
> 
> Regarding streams, our stream module can be used to model a stream
> channel such as AXI stream but also other similar stream protocols. We
> actually don't use the AXI stream terminology [in hw/core/stream.c].
> E.g, we use buf instead of DATA, EOP (end-of-packet) instead of LAST and
> have a flow-control mechanism that doesn't refer to valid/ready.  IMO,
> since we're not matching specific protocol names, it would be fine to
> switch to generic terms like Source and Sink.
> 
> Therefore,
> 
> Acked-by: Paolo Bonzini <pbonzini@redhat.com>
>

Thanks Paolo,

Yes, looks good to me!
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>


 
> 
> > ---
> >  include/hw/ssi/xilinx_spips.h |  2 +-
> >  include/hw/stream.h           | 46 +++++++++++++++++------------------
> >  hw/core/stream.c              | 20 +++++++--------
> >  hw/dma/xilinx_axidma.c        | 32 ++++++++++++------------
> >  hw/net/xilinx_axienet.c       | 20 +++++++--------
> >  hw/ssi/xilinx_spips.c         |  2 +-
> >  6 files changed, 61 insertions(+), 61 deletions(-)
> > 
> > diff --git a/include/hw/ssi/xilinx_spips.h b/include/hw/ssi/xilinx_spips.h
> > index 6a39b55a7bd..fde8a3ebda6 100644
> > --- a/include/hw/ssi/xilinx_spips.h
> > +++ b/include/hw/ssi/xilinx_spips.h
> > @@ -97,7 +97,7 @@ typedef struct {
> >  typedef struct {
> >      XilinxQSPIPS parent_obj;
> >  
> > -    StreamSlave *dma;
> > +    StreamSink *dma;
> >      int gqspi_irqline;
> >  
> >      uint32_t regs[XLNX_ZYNQMP_SPIPS_R_MAX];
> > diff --git a/include/hw/stream.h b/include/hw/stream.h
> > index ed09e83683d..8ca161991ca 100644
> > --- a/include/hw/stream.h
> > +++ b/include/hw/stream.h
> > @@ -3,52 +3,52 @@
> >  
> >  #include "qom/object.h"
> >  
> > -/* stream slave. Used until qdev provides a generic way.  */
> > -#define TYPE_STREAM_SLAVE "stream-slave"
> > +/* stream sink. Used until qdev provides a generic way.  */
> > +#define TYPE_STREAM_SINK "stream-slave"
> >  
> > -#define STREAM_SLAVE_CLASS(klass) \
> > -     OBJECT_CLASS_CHECK(StreamSlaveClass, (klass), TYPE_STREAM_SLAVE)
> > -#define STREAM_SLAVE_GET_CLASS(obj) \
> > -    OBJECT_GET_CLASS(StreamSlaveClass, (obj), TYPE_STREAM_SLAVE)
> > -#define STREAM_SLAVE(obj) \
> > -     INTERFACE_CHECK(StreamSlave, (obj), TYPE_STREAM_SLAVE)
> > +#define STREAM_SINK_CLASS(klass) \
> > +     OBJECT_CLASS_CHECK(StreamSinkClass, (klass), TYPE_STREAM_SINK)
> > +#define STREAM_SINK_GET_CLASS(obj) \
> > +    OBJECT_GET_CLASS(StreamSinkClass, (obj), TYPE_STREAM_SINK)
> > +#define STREAM_SINK(obj) \
> > +     INTERFACE_CHECK(StreamSink, (obj), TYPE_STREAM_SINK)
> >  
> > -typedef struct StreamSlave StreamSlave;
> > +typedef struct StreamSink StreamSink;
> >  
> >  typedef void (*StreamCanPushNotifyFn)(void *opaque);
> >  
> > -typedef struct StreamSlaveClass {
> > +typedef struct StreamSinkClass {
> >      InterfaceClass parent;
> >      /**
> > -     * can push - determine if a stream slave is capable of accepting at least
> > +     * can push - determine if a stream sink is capable of accepting at least
> >       * one byte of data. Returns false if cannot accept. If not implemented, the
> > -     * slave is assumed to always be capable of receiving.
> > -     * @notify: Optional callback that the slave will call when the slave is
> > +     * sink is assumed to always be capable of receiving.
> > +     * @notify: Optional callback that the sink will call when the sink is
> >       * capable of receiving again. Only called if false is returned.
> >       * @notify_opaque: opaque data to pass to notify call.
> >       */
> > -    bool (*can_push)(StreamSlave *obj, StreamCanPushNotifyFn notify,
> > +    bool (*can_push)(StreamSink *obj, StreamCanPushNotifyFn notify,
> >                       void *notify_opaque);
> >      /**
> > -     * push - push data to a Stream slave. The number of bytes pushed is
> > -     * returned. If the slave short returns, the master must wait before trying
> > -     * again, the slave may continue to just return 0 waiting for the vm time to
> > +     * push - push data to a Stream sink. The number of bytes pushed is
> > +     * returned. If the sink short returns, the master must wait before trying
> > +     * again, the sink may continue to just return 0 waiting for the vm time to
> >       * advance. The can_push() function can be used to trap the point in time
> > -     * where the slave is ready to receive again, otherwise polling on a QEMU
> > +     * where the sink is ready to receive again, otherwise polling on a QEMU
> >       * timer will work.
> > -     * @obj: Stream slave to push to
> > +     * @obj: Stream sink to push to
> >       * @buf: Data to write
> >       * @len: Maximum number of bytes to write
> >       * @eop: End of packet flag
> >       */
> > -    size_t (*push)(StreamSlave *obj, unsigned char *buf, size_t len, bool eop);
> > -} StreamSlaveClass;
> > +    size_t (*push)(StreamSink *obj, unsigned char *buf, size_t len, bool eop);
> > +} StreamSinkClass;
> >  
> >  size_t
> > -stream_push(StreamSlave *sink, uint8_t *buf, size_t len, bool eop);
> > +stream_push(StreamSink *sink, uint8_t *buf, size_t len, bool eop);
> >  
> >  bool
> > -stream_can_push(StreamSlave *sink, StreamCanPushNotifyFn notify,
> > +stream_can_push(StreamSink *sink, StreamCanPushNotifyFn notify,
> >                  void *notify_opaque);
> >  
> >  
> > diff --git a/hw/core/stream.c b/hw/core/stream.c
> > index a65ad1208d8..19477d0f2df 100644
> > --- a/hw/core/stream.c
> > +++ b/hw/core/stream.c
> > @@ -3,32 +3,32 @@
> >  #include "qemu/module.h"
> >  
> >  size_t
> > -stream_push(StreamSlave *sink, uint8_t *buf, size_t len, bool eop)
> > +stream_push(StreamSink *sink, uint8_t *buf, size_t len, bool eop)
> >  {
> > -    StreamSlaveClass *k =  STREAM_SLAVE_GET_CLASS(sink);
> > +    StreamSinkClass *k =  STREAM_SINK_GET_CLASS(sink);
> >  
> >      return k->push(sink, buf, len, eop);
> >  }
> >  
> >  bool
> > -stream_can_push(StreamSlave *sink, StreamCanPushNotifyFn notify,
> > +stream_can_push(StreamSink *sink, StreamCanPushNotifyFn notify,
> >                  void *notify_opaque)
> >  {
> > -    StreamSlaveClass *k =  STREAM_SLAVE_GET_CLASS(sink);
> > +    StreamSinkClass *k =  STREAM_SINK_GET_CLASS(sink);
> >  
> >      return k->can_push ? k->can_push(sink, notify, notify_opaque) : true;
> >  }
> >  
> > -static const TypeInfo stream_slave_info = {
> > -    .name          = TYPE_STREAM_SLAVE,
> > +static const TypeInfo stream_sink_info = {
> > +    .name          = TYPE_STREAM_SINK,
> >      .parent        = TYPE_INTERFACE,
> > -    .class_size = sizeof(StreamSlaveClass),
> > +    .class_size = sizeof(StreamSinkClass),
> >  };
> >  
> >  
> > -static void stream_slave_register_types(void)
> > +static void stream_sink_register_types(void)
> >  {
> > -    type_register_static(&stream_slave_info);
> > +    type_register_static(&stream_sink_info);
> >  }
> >  
> > -type_init(stream_slave_register_types)
> > +type_init(stream_sink_register_types)
> > diff --git a/hw/dma/xilinx_axidma.c b/hw/dma/xilinx_axidma.c
> > index a4812e480a0..cf12a852ea1 100644
> > --- a/hw/dma/xilinx_axidma.c
> > +++ b/hw/dma/xilinx_axidma.c
> > @@ -131,8 +131,8 @@ struct XilinxAXIDMA {
> >      AddressSpace as;
> >  
> >      uint32_t freqhz;
> > -    StreamSlave *tx_data_dev;
> > -    StreamSlave *tx_control_dev;
> > +    StreamSink *tx_data_dev;
> > +    StreamSink *tx_control_dev;
> >      XilinxAXIDMAStreamSlave rx_data_dev;
> >      XilinxAXIDMAStreamSlave rx_control_dev;
> >  
> > @@ -264,8 +264,8 @@ static void stream_complete(struct Stream *s)
> >      ptimer_transaction_commit(s->ptimer);
> >  }
> >  
> > -static void stream_process_mem2s(struct Stream *s, StreamSlave *tx_data_dev,
> > -                                 StreamSlave *tx_control_dev)
> > +static void stream_process_mem2s(struct Stream *s, StreamSink *tx_data_dev,
> > +                                 StreamSink *tx_control_dev)
> >  {
> >      uint32_t prev_d;
> >      uint32_t txlen;
> > @@ -387,7 +387,7 @@ static void xilinx_axidma_reset(DeviceState *dev)
> >  }
> >  
> >  static size_t
> > -xilinx_axidma_control_stream_push(StreamSlave *obj, unsigned char *buf,
> > +xilinx_axidma_control_stream_push(StreamSink *obj, unsigned char *buf,
> >                                    size_t len, bool eop)
> >  {
> >      XilinxAXIDMAStreamSlave *cs = XILINX_AXI_DMA_CONTROL_STREAM(obj);
> > @@ -403,7 +403,7 @@ xilinx_axidma_control_stream_push(StreamSlave *obj, unsigned char *buf,
> >  }
> >  
> >  static bool
> > -xilinx_axidma_data_stream_can_push(StreamSlave *obj,
> > +xilinx_axidma_data_stream_can_push(StreamSink *obj,
> >                                     StreamCanPushNotifyFn notify,
> >                                     void *notify_opaque)
> >  {
> > @@ -420,7 +420,7 @@ xilinx_axidma_data_stream_can_push(StreamSlave *obj,
> >  }
> >  
> >  static size_t
> > -xilinx_axidma_data_stream_push(StreamSlave *obj, unsigned char *buf, size_t len,
> > +xilinx_axidma_data_stream_push(StreamSink *obj, unsigned char *buf, size_t len,
> >                                 bool eop)
> >  {
> >      XilinxAXIDMAStreamSlave *ds = XILINX_AXI_DMA_DATA_STREAM(obj);
> > @@ -591,9 +591,9 @@ static void xilinx_axidma_init(Object *obj)
> >  static Property axidma_properties[] = {
> >      DEFINE_PROP_UINT32("freqhz", XilinxAXIDMA, freqhz, 50000000),
> >      DEFINE_PROP_LINK("axistream-connected", XilinxAXIDMA,
> > -                     tx_data_dev, TYPE_STREAM_SLAVE, StreamSlave *),
> > +                     tx_data_dev, TYPE_STREAM_SINK, StreamSink *),
> >      DEFINE_PROP_LINK("axistream-control-connected", XilinxAXIDMA,
> > -                     tx_control_dev, TYPE_STREAM_SLAVE, StreamSlave *),
> > +                     tx_control_dev, TYPE_STREAM_SINK, StreamSink *),
> >      DEFINE_PROP_END_OF_LIST(),
> >  };
> >  
> > @@ -606,21 +606,21 @@ static void axidma_class_init(ObjectClass *klass, void *data)
> >      device_class_set_props(dc, axidma_properties);
> >  }
> >  
> > -static StreamSlaveClass xilinx_axidma_data_stream_class = {
> > +static StreamSinkClass xilinx_axidma_data_stream_class = {
> >      .push = xilinx_axidma_data_stream_push,
> >      .can_push = xilinx_axidma_data_stream_can_push,
> >  };
> >  
> > -static StreamSlaveClass xilinx_axidma_control_stream_class = {
> > +static StreamSinkClass xilinx_axidma_control_stream_class = {
> >      .push = xilinx_axidma_control_stream_push,
> >  };
> >  
> >  static void xilinx_axidma_stream_class_init(ObjectClass *klass, void *data)
> >  {
> > -    StreamSlaveClass *ssc = STREAM_SLAVE_CLASS(klass);
> > +    StreamSinkClass *ssc = STREAM_SINK_CLASS(klass);
> >  
> > -    ssc->push = ((StreamSlaveClass *)data)->push;
> > -    ssc->can_push = ((StreamSlaveClass *)data)->can_push;
> > +    ssc->push = ((StreamSinkClass *)data)->push;
> > +    ssc->can_push = ((StreamSinkClass *)data)->can_push;
> >  }
> >  
> >  static const TypeInfo axidma_info = {
> > @@ -638,7 +638,7 @@ static const TypeInfo xilinx_axidma_data_stream_info = {
> >      .class_init    = xilinx_axidma_stream_class_init,
> >      .class_data    = &xilinx_axidma_data_stream_class,
> >      .interfaces = (InterfaceInfo[]) {
> > -        { TYPE_STREAM_SLAVE },
> > +        { TYPE_STREAM_SINK },
> >          { }
> >      }
> >  };
> > @@ -650,7 +650,7 @@ static const TypeInfo xilinx_axidma_control_stream_info = {
> >      .class_init    = xilinx_axidma_stream_class_init,
> >      .class_data    = &xilinx_axidma_control_stream_class,
> >      .interfaces = (InterfaceInfo[]) {
> > -        { TYPE_STREAM_SLAVE },
> > +        { TYPE_STREAM_SINK },
> >          { }
> >      }
> >  };
> > diff --git a/hw/net/xilinx_axienet.c b/hw/net/xilinx_axienet.c
> > index 2e89f236b4a..0c4ac727207 100644
> > --- a/hw/net/xilinx_axienet.c
> > +++ b/hw/net/xilinx_axienet.c
> > @@ -323,8 +323,8 @@ struct XilinxAXIEnet {
> >      SysBusDevice busdev;
> >      MemoryRegion iomem;
> >      qemu_irq irq;
> > -    StreamSlave *tx_data_dev;
> > -    StreamSlave *tx_control_dev;
> > +    StreamSink *tx_data_dev;
> > +    StreamSink *tx_control_dev;
> >      XilinxAXIEnetStreamSlave rx_data_dev;
> >      XilinxAXIEnetStreamSlave rx_control_dev;
> >      NICState *nic;
> > @@ -855,7 +855,7 @@ static ssize_t eth_rx(NetClientState *nc, const uint8_t *buf, size_t size)
> >  }
> >  
> >  static size_t
> > -xilinx_axienet_control_stream_push(StreamSlave *obj, uint8_t *buf, size_t len,
> > +xilinx_axienet_control_stream_push(StreamSink *obj, uint8_t *buf, size_t len,
> >                                     bool eop)
> >  {
> >      int i;
> > @@ -877,7 +877,7 @@ xilinx_axienet_control_stream_push(StreamSlave *obj, uint8_t *buf, size_t len,
> >  }
> >  
> >  static size_t
> > -xilinx_axienet_data_stream_push(StreamSlave *obj, uint8_t *buf, size_t size,
> > +xilinx_axienet_data_stream_push(StreamSink *obj, uint8_t *buf, size_t size,
> >                                  bool eop)
> >  {
> >      XilinxAXIEnetStreamSlave *ds = XILINX_AXI_ENET_DATA_STREAM(obj);
> > @@ -1005,9 +1005,9 @@ static Property xilinx_enet_properties[] = {
> >      DEFINE_PROP_UINT32("txmem", XilinxAXIEnet, c_txmem, 0x1000),
> >      DEFINE_NIC_PROPERTIES(XilinxAXIEnet, conf),
> >      DEFINE_PROP_LINK("axistream-connected", XilinxAXIEnet,
> > -                     tx_data_dev, TYPE_STREAM_SLAVE, StreamSlave *),
> > +                     tx_data_dev, TYPE_STREAM_SINK, StreamSink *),
> >      DEFINE_PROP_LINK("axistream-control-connected", XilinxAXIEnet,
> > -                     tx_control_dev, TYPE_STREAM_SLAVE, StreamSlave *),
> > +                     tx_control_dev, TYPE_STREAM_SINK, StreamSink *),
> >      DEFINE_PROP_END_OF_LIST(),
> >  };
> >  
> > @@ -1023,14 +1023,14 @@ static void xilinx_enet_class_init(ObjectClass *klass, void *data)
> >  static void xilinx_enet_control_stream_class_init(ObjectClass *klass,
> >                                                    void *data)
> >  {
> > -    StreamSlaveClass *ssc = STREAM_SLAVE_CLASS(klass);
> > +    StreamSinkClass *ssc = STREAM_SINK_CLASS(klass);
> >  
> >      ssc->push = xilinx_axienet_control_stream_push;
> >  }
> >  
> >  static void xilinx_enet_data_stream_class_init(ObjectClass *klass, void *data)
> >  {
> > -    StreamSlaveClass *ssc = STREAM_SLAVE_CLASS(klass);
> > +    StreamSinkClass *ssc = STREAM_SINK_CLASS(klass);
> >  
> >      ssc->push = xilinx_axienet_data_stream_push;
> >  }
> > @@ -1049,7 +1049,7 @@ static const TypeInfo xilinx_enet_data_stream_info = {
> >      .instance_size = sizeof(struct XilinxAXIEnetStreamSlave),
> >      .class_init    = xilinx_enet_data_stream_class_init,
> >      .interfaces = (InterfaceInfo[]) {
> > -            { TYPE_STREAM_SLAVE },
> > +            { TYPE_STREAM_SINK },
> >              { }
> >      }
> >  };
> > @@ -1060,7 +1060,7 @@ static const TypeInfo xilinx_enet_control_stream_info = {
> >      .instance_size = sizeof(struct XilinxAXIEnetStreamSlave),
> >      .class_init    = xilinx_enet_control_stream_class_init,
> >      .interfaces = (InterfaceInfo[]) {
> > -            { TYPE_STREAM_SLAVE },
> > +            { TYPE_STREAM_SINK },
> >              { }
> >      }
> >  };
> > diff --git a/hw/ssi/xilinx_spips.c b/hw/ssi/xilinx_spips.c
> > index b9371dbf8d7..6109ba55107 100644
> > --- a/hw/ssi/xilinx_spips.c
> > +++ b/hw/ssi/xilinx_spips.c
> > @@ -1353,7 +1353,7 @@ static void xlnx_zynqmp_qspips_init(Object *obj)
> >  {
> >      XlnxZynqMPQSPIPS *rq = XLNX_ZYNQMP_QSPIPS(obj);
> >  
> > -    object_property_add_link(obj, "stream-connected-dma", TYPE_STREAM_SLAVE,
> > +    object_property_add_link(obj, "stream-connected-dma", TYPE_STREAM_SINK,
> >                               (Object **)&rq->dma,
> >                               object_property_allow_set_link,
> >                               OBJ_PROP_LINK_STRONG);
> > 
> 

