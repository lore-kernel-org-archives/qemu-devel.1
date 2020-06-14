Return-Path: <SRS0=clLO=73=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3C14C433E0
	for <qemu-devel@archiver.kernel.org>; Sun, 14 Jun 2020 19:05:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D2B8206D7
	for <qemu-devel@archiver.kernel.org>; Sun, 14 Jun 2020 19:05:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pt96LGSc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D2B8206D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45738 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jkXwZ-0000og-Bd
	for qemu-devel@archiver.kernel.org; Sun, 14 Jun 2020 15:05:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45176)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <coiby.xu@gmail.com>)
 id 1jkXvu-0000K5-6P; Sun, 14 Jun 2020 15:04:42 -0400
Received: from mail-pj1-x1043.google.com ([2607:f8b0:4864:20::1043]:36040)
 by eggs.gnu.org with esmtps (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <coiby.xu@gmail.com>)
 id 1jkXvs-0005gK-Ix; Sun, 14 Jun 2020 15:04:41 -0400
Received: by mail-pj1-x1043.google.com with SMTP id h22so2710827pjf.1;
 Sun, 14 Jun 2020 12:04:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:date:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=8uH4qd96C9xz/YWsZIPklOhj9g64y1F9B+RPEky30bQ=;
 b=Pt96LGScgevjWMLhcvPKUaRPeF54i0Frw50TM+fez8qqYQMJ/PsGJg1DvQPp76RNaL
 B9Qc2kcVzg+wq5wnQKtTtr44BKuNAXPCFyguWzmcJdosSLP0z6ihWm/x3WUChNIncAvR
 5qiTXWu/vM41i4ukmmk8/nIkW3QVGAVN3SdDPswzVNwzGFUJMFaWqccM6ROxtur0zGIz
 ItptidGDOsfKOwqFVcokm+qNaDK9UAyJDtuwaWb01ExIhQpxq8BwSi9RmoEK2IIIbszg
 7Bei3eEDpHFB9EpXSreiCvAORD1LCGNx2UWmPFqYUbZaFc06zAwAGXIgvzD9Wmy79sji
 A0TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:date:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=8uH4qd96C9xz/YWsZIPklOhj9g64y1F9B+RPEky30bQ=;
 b=ffyPAI2/79hTKSC44RuAiXf4uoRhCeAov1Y/WYoeuToJTpfSWaudnFKd3xkpkqA+Qh
 HSC1Ch/wcFbPSkFAAmLAzjvtwdwzNSB0X71fjC2QA9m/i/SQUTspY6XamH4JdJ3UUU0R
 6kn+NpuUSc+nyu4ckdNxcTcfVouLMx+Hv/lvq4pDaFcMvqsxoEK463rooONfkO2WBeFF
 LkPijNoAbYo4/DbXYoeWwOkGGTycLlkP2jTU5YqwnL46E2WL2aVSeZIpr0DyqrGAhDy6
 0DGzjCGisOYA497YxdyXsNwwVoJtjikW6sU6KzmsUXTGTTRPdcRZdUnThk2G8s0kZq3H
 3MqQ==
X-Gm-Message-State: AOAM5316outFzIpH7wT+AqeVANLuA1Nf98mgg69HDB1hMqFbVtlNL+Xx
 /XNoO6TtOR8JFKMH7D2I6cs=
X-Google-Smtp-Source: ABdhPJxJslKVNauz0eziUqJp2LfSp1rnY3TV0+hTV0RcvDotpam5+cVAQqUT26fwb7In8Kpbc/38EA==
X-Received: by 2002:a17:902:9f90:: with SMTP id
 g16mr19761551plq.146.1592161468527; 
 Sun, 14 Jun 2020 12:04:28 -0700 (PDT)
Received: from localhost ([2001:e42:102:1532:160:16:113:140])
 by smtp.gmail.com with ESMTPSA id n2sm12190995pfd.125.2020.06.14.12.04.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 14 Jun 2020 12:04:28 -0700 (PDT)
From: Coiby Xu <coiby.xu@gmail.com>
X-Google-Original-From: Coiby Xu <Coiby.Xu@gmail.com>
Date: Mon, 15 Jun 2020 03:04:24 +0800
To: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH v8 3/4] vhost-user block device backend server
Message-ID: <20200614190424.4mabhchxaqtqmo6v@r>
References: <20200604233538.256325-1-coiby.xu@gmail.com>
 <20200604233538.256325-4-coiby.xu@gmail.com>
 <20200611152452.GC77457@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20200611152452.GC77457@stefanha-x1.localdomain>
Received-SPF: pass client-ip=2607:f8b0:4864:20::1043;
 envelope-from=coiby.xu@gmail.com; helo=mail-pj1-x1043.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: kwolf@redhat.com, "open list:Block layer core" <qemu-block@nongnu.org>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, bharatlkmlkvm@gmail.com,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Jun 11, 2020 at 04:24:52PM +0100, Stefan Hajnoczi wrote:
>On Fri, Jun 05, 2020 at 07:35:37AM +0800, Coiby Xu wrote:
>> +static void coroutine_fn vu_block_virtio_process_req(void *opaque)
>> +{
>> +    struct req_data *data = opaque;
>> +    VuServer *server = data->server;
>> +    VuVirtq *vq = data->vq;
>> +    VuVirtqElement *elem = data->elem;
>> +    uint32_t type;
>> +    VuBlockReq *req;
>> +
>> +    VuBlockDev *vdev_blk = get_vu_block_device_by_server(server);
>> +    BlockBackend *backend = vdev_blk->backend;
>> +
>> +    struct iovec *in_iov = elem->in_sg;
>> +    struct iovec *out_iov = elem->out_sg;
>> +    unsigned in_num = elem->in_num;
>> +    unsigned out_num = elem->out_num;
>> +    /* refer to hw/block/virtio_blk.c */
>> +    if (elem->out_num < 1 || elem->in_num < 1) {
>> +        error_report("virtio-blk request missing headers");
>> +        free(elem);
>> +        return;
>> +    }
>> +
>> +    req = g_new0(VuBlockReq, 1);
>
>elem was allocated with enough space for VuBlockReq. Can this allocation
>be eliminated?
>
>  typedef struct VuBlockReq {
>-     VuVirtqElement *elem;
>+     VuVirtqElement elem;
>      int64_t sector_num;
>      size_t size;
>      struct virtio_blk_inhdr *in;
>      struct virtio_blk_outhdr out;
>      VuServer *server;
>      struct VuVirtq *vq;
>  } VuBlockReq;

Thank you for review this patch. Other issues for this patch have been
addressed in v9 except for this one. I'm not sure what you mean. I can't
find a way that doesn't require to allocate a VuBlockReq struct.


--
Best regards,
Coiby

