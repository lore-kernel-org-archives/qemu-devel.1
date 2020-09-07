Return-Path: <SRS0=tzYv=CQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27BCBC43461
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 01:38:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5DF5D20708
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 01:38:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Onx1Inbr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DF5D20708
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54110 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kF66b-0001ra-AB
	for qemu-devel@archiver.kernel.org; Sun, 06 Sep 2020 21:38:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57508)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liq3ea@gmail.com>) id 1kF65v-00018L-5w
 for qemu-devel@nongnu.org; Sun, 06 Sep 2020 21:37:19 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:33116)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <liq3ea@gmail.com>) id 1kF65t-0005UU-L1
 for qemu-devel@nongnu.org; Sun, 06 Sep 2020 21:37:18 -0400
Received: by mail-ot1-x343.google.com with SMTP id m12so8077073otr.0
 for <qemu-devel@nongnu.org>; Sun, 06 Sep 2020 18:37:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=Ol8E0wQZvCEK3KqdN7lKvOrhE+yZkFZ/oQIJ9nbRIIQ=;
 b=Onx1InbrJX14bIzDq/itDaMOa8ZffK6Lmk55sCbmgB81zxiCNngpg/KjHEhkcsBgUM
 8pRtjPPG7cqQ0m31KUuev77a82KWV/WiB82UfwsfSI9T97oVrbDtKjKlY8UHgrFu/x3y
 hjUQIC/+34UVRLOMaJuk8f5pUvp3uxuwqzNTl7CgpyeckqpGbV4vg1XqRzSacLqXHJAC
 t01cL/uhkJg5kaBNV9eOR2MapJjzojsPW2pce8WJy2va5QjU0h+dHQ3mlfHr5Oty7sv7
 7VOajWYbfUHClga3kjSHk5cWp3iKnN/IRf49mlVQGaNKqUG/pXttprsXELtAp8NZpY6L
 IhOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=Ol8E0wQZvCEK3KqdN7lKvOrhE+yZkFZ/oQIJ9nbRIIQ=;
 b=aNRElTorrn7KlWi0Kt1dXSMVvFuhV5aJsWNmzRS9kDrdF3ZHJPR7gmkJWW4pcgnGwF
 tc9Hg7rebaczSU3xNw3z3cHFxYZHOT75CS2cCXW8sMBxBCUA/tP+aiAPTSQWWBBjaYfr
 yAxOvuArYv5k9ny7tnZZGVxsfs2S2aORvqEIWL8Z2gKu85whlqqTCkuSI6qIB8ND5t94
 77W/YLN5L0PBZSTXWrYWfGUx3Q5lu6D0L/pQRP9+Rc0KBUDQ7SDWkzPQHwFGo44MWRLO
 TtHc5vFxFyqHqdf052Nln7MfH2aHSR3ZbGbESXcScDhhJhELnU/ZoqkcHQA66Epbvf3A
 s4aw==
X-Gm-Message-State: AOAM532OrVu28RMhovzoYIbf7/Jz5jvloye3BSm+mkhclbm3JF915/e/
 gJsOcV/jJeZFyc31sdORHYvulSGq7zWus/gQqbk=
X-Google-Smtp-Source: ABdhPJwqXXLZLS586fXeBo9v4BkWLvemPqDU0gJdnecPedFrrK5EKcVETZJ/z/80ok9fre71bjGsPmMM8Q2tq+lpqPA=
X-Received: by 2002:a9d:5e11:: with SMTP id d17mr879462oti.333.1599442636553; 
 Sun, 06 Sep 2020 18:37:16 -0700 (PDT)
MIME-Version: 1.0
References: <20200816142245.17556-1-liq3ea@163.com>
 <CAKXe6SJjrTZ5cW3h227MUpPt8jsPimcrjiN8-WXSbVCZvdkCFg@mail.gmail.com>
In-Reply-To: <CAKXe6SJjrTZ5cW3h227MUpPt8jsPimcrjiN8-WXSbVCZvdkCFg@mail.gmail.com>
From: Li Qiang <liq3ea@gmail.com>
Date: Mon, 7 Sep 2020 09:36:40 +0800
Message-ID: <CAKXe6SLt8r3bm0bGiGQ5sPoz-8xWrZkpnRFa1GEaT5_iRO1+Rg@mail.gmail.com>
Subject: Re: [PATCH v2] virtio-mem: detach the element from the virtqueue when
 error occurs
To: Li Qiang <liq3ea@163.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::343;
 envelope-from=liq3ea@gmail.com; helo=mail-ot1-x343.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: David Hildenbrand <david@redhat.com>,
 Qemu Developers <qemu-devel@nongnu.org>, "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Ping!

Li Qiang <liq3ea@gmail.com> =E4=BA=8E2020=E5=B9=B48=E6=9C=8828=E6=97=A5=E5=
=91=A8=E4=BA=94 =E4=B8=8A=E5=8D=889:21=E5=86=99=E9=81=93=EF=BC=9A
>
> Kindly ping.
>
> Li Qiang <liq3ea@163.com> =E4=BA=8E2020=E5=B9=B48=E6=9C=8816=E6=97=A5=E5=
=91=A8=E6=97=A5 =E4=B8=8B=E5=8D=8810:23=E5=86=99=E9=81=93=EF=BC=9A
> >
> > If error occurs while processing the virtio request we should call
> > 'virtqueue_detach_element' to detach the element from the virtqueue
> > before free the elem.
> >
> > Signed-off-by: Li Qiang <liq3ea@163.com>
> > ---
> > Change since v1:
> > Change the subject
> > Avoid using the goto label
> >
> >  hw/virtio/virtio-mem.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/hw/virtio/virtio-mem.c b/hw/virtio/virtio-mem.c
> > index 7740fc613f..e6ffc781b3 100644
> > --- a/hw/virtio/virtio-mem.c
> > +++ b/hw/virtio/virtio-mem.c
> > @@ -318,6 +318,7 @@ static void virtio_mem_handle_request(VirtIODevice =
*vdev, VirtQueue *vq)
> >          if (iov_to_buf(elem->out_sg, elem->out_num, 0, &req, len) < le=
n) {
> >              virtio_error(vdev, "virtio-mem protocol violation: invalid=
 request"
> >                           " size: %d", len);
> > +            virtqueue_detach_element(vq, elem, 0);
> >              g_free(elem);
> >              return;
> >          }
> > @@ -327,6 +328,7 @@ static void virtio_mem_handle_request(VirtIODevice =
*vdev, VirtQueue *vq)
> >              virtio_error(vdev, "virtio-mem protocol violation: not eno=
ugh space"
> >                           " for response: %zu",
> >                           iov_size(elem->in_sg, elem->in_num));
> > +            virtqueue_detach_element(vq, elem, 0);
> >              g_free(elem);
> >              return;
> >          }
> > @@ -348,6 +350,7 @@ static void virtio_mem_handle_request(VirtIODevice =
*vdev, VirtQueue *vq)
> >          default:
> >              virtio_error(vdev, "virtio-mem protocol violation: unknown=
 request"
> >                           " type: %d", type);
> > +            virtqueue_detach_element(vq, elem, 0);
> >              g_free(elem);
> >              return;
> >          }
> > --
> > 2.17.1
> >
> >

