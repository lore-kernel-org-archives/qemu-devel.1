Return-Path: <SRS0=IkQf=EJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CED25C2D0A3
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 12:07:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0FFB822243
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 12:06:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QBFNZUsr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FFB822243
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60372 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZv5W-00085w-RP
	for qemu-devel@archiver.kernel.org; Tue, 03 Nov 2020 07:06:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44868)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kZv3z-0007F7-Ry
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 07:05:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:34698)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kZv3x-0002zG-5X
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 07:05:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604405119;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Hjjlk+YJUvL+3++ntw9sC1iOXQ24d5fobxPDvHR+w9I=;
 b=QBFNZUsr061xbDcOMplM2+HnfOejFsq6Zwp8nhhu8a0hau77QSdWFRDuDH83QhKKHLS+Xj
 9n1PhK5y9Bpg+eFwKje80wjlSRt2Z+taP4XfdRJEQEaVqIVwcUbsJdE6eEikOPmcyv99P+
 q4vYi4dBD3QiUgJtLkBI7BoNZA2GnIw=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-537-0oejOqMjOSWZDMUzLAADhg-1; Tue, 03 Nov 2020 07:05:17 -0500
X-MC-Unique: 0oejOqMjOSWZDMUzLAADhg-1
Received: by mail-wr1-f70.google.com with SMTP id q15so7739353wrw.8
 for <qemu-devel@nongnu.org>; Tue, 03 Nov 2020 04:05:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=Hjjlk+YJUvL+3++ntw9sC1iOXQ24d5fobxPDvHR+w9I=;
 b=IVJjx5h1hLEOhSAWMY4t2fHT2lRYxN8k3VIFb6DktQQL0KKtwkePXOBarH2OujCau4
 QAby6qqTFsjnydWTORuYnMEAfihVA1ZElttTCRzEWYge7+DwQnttShyd05KBr9UHjnqn
 zM/CtZxtHnMquJy4nOA9mELhe9e4CoTH/eEbxuPtv3TXLJV2IY/ONI5a4DrYOUQsd+AW
 0eoeXR2QJAunpUxxFtYxKLugjE47Ddl+L/CT4fsnKslrP2Ler4gT6gHfoscFFwH3HedN
 eATIvpzdcqDpHoQ73zO2OR6npcnD2Anl6Vs0c7TtViq79bVPmn4cPaL+qUElKbRYacsd
 9P9Q==
X-Gm-Message-State: AOAM533oFuYE4rGJb9DaLx38QtYMvrjl/8FAOzh84k2vho49yUP8z8xQ
 iSnZgxwDDIi9ru4yboheH2WnUZHLimsPctoK8DaRu3++E/+7SFFaUQxns36E/PkxjsCUV0fs9gJ
 h50CWK/CSqIXWdpk=
X-Received: by 2002:adf:df02:: with SMTP id y2mr27642051wrl.403.1604405116503; 
 Tue, 03 Nov 2020 04:05:16 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxICMcecKCoVhHgnO6IOJP+eBvtkSoc9Vavg2oNhmYbIZ7NsjQbcradu5Dl1vkNmoIdNYBvbA==
X-Received: by 2002:adf:df02:: with SMTP id y2mr27642023wrl.403.1604405116299; 
 Tue, 03 Nov 2020 04:05:16 -0800 (PST)
Received: from redhat.com (bzq-79-176-118-93.red.bezeqint.net. [79.176.118.93])
 by smtp.gmail.com with ESMTPSA id m126sm1878959wmm.0.2020.11.03.04.05.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2020 04:05:15 -0800 (PST)
Date: Tue, 3 Nov 2020 07:05:08 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Bin Meng <bmeng.cn@gmail.com>
Subject: Re: [PATCH] hw/9pfs: virtio-9p: Ensure config space is a multiple of
 4 bytes
Message-ID: <20201103065732-mutt-send-email-mst@kernel.org>
References: <1603959941-9689-1-git-send-email-bmeng.cn@gmail.com>
 <20201030051920-mutt-send-email-mst@kernel.org>
 <CAEUhbmV+t06o7RjhfHiCS2P6UZLm9dra+ev_eX-qRahoyx8HJA@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAEUhbmV+t06o7RjhfHiCS2P6UZLm9dra+ev_eX-qRahoyx8HJA@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/03 00:03:41
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Bin Meng <bin.meng@windriver.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>, Greg Kurz <groug@kaod.org>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Nov 03, 2020 at 02:26:10PM +0800, Bin Meng wrote:
> Hi Michael,
> 
> On Fri, Oct 30, 2020 at 5:29 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Thu, Oct 29, 2020 at 04:25:41PM +0800, Bin Meng wrote:
> > > From: Bin Meng <bin.meng@windriver.com>
> > >
> > > At present the virtio device config space access is handled by the
> > > virtio_config_readX() and virtio_config_writeX() APIs. They perform
> > > a sanity check on the result of address plus size against the config
> > > space size before the access occurs.
> > >
> > > For unaligned access, the last converted naturally aligned access
> > > will fail the sanity check on 9pfs. For example, with a mount_tag
> > > `p9fs`, if guest software tries to read the mount_tag via a 4 byte
> > > read at the mount_tag offset which is not 4 byte aligned, the read
> > > result will be `p9\377\377`, which is wrong.
> > >
> > > This changes the size of device config space to be a multiple of 4
> > > bytes so that correct result can be returned in all circumstances.
> > >
> > > Signed-off-by: Bin Meng <bin.meng@windriver.com>
> >
> >
> >
> > The patch is ok, but I'd like to clarify the commit log.
> 
> Thanks for the review.
> 
> >
> > If I understand correctly, what happens is:
> > - tag is set to a value that is not a multiple of 4 bytes
> 
> It's not about the mount_tag value, but the length of the mount_tag is 4.
> 
> > - guest attempts to read the last 4 bytes of the tag
> 
> Yep. So the config space of a 9pfs looks like the following:
> 
> offset: 0x14, size: 2 bytes indicating the length of the following mount_tag
> offset: 0x16, size: value of (offset 0x14).
> 
> When a 4-byte mount_tag is given, guest software is subject to read 4
> bytes (value read from offset 0x14) at offset 0x16.


Well looking at Linux guest code:


static inline void __virtio_cread_many(struct virtio_device *vdev,
                                       unsigned int offset,
                                       void *buf, size_t count, size_t bytes)
{
        u32 old, gen = vdev->config->generation ?
                vdev->config->generation(vdev) : 0;
        int i;  
                                   
        might_sleep();             
        do {
                old = gen;

                for (i = 0; i < count; i++)
                        vdev->config->get(vdev, offset + bytes * i,
                                          buf + i * bytes, bytes);
        
                gen = vdev->config->generation ?
                        vdev->config->generation(vdev) : 0;
        } while (gen != old);
}
        


static inline void virtio_cread_bytes(struct virtio_device *vdev,
                                      unsigned int offset,
                                      void *buf, size_t len) 
{           
        __virtio_cread_many(vdev, offset, buf, len, 1);
}

and:


        virtio_cread_bytes(vdev, offsetof(struct virtio_9p_config, tag),
                           tag, tag_len);



So guest is doing multiple 1-byte reads.


Spec actually says:
	For device configuration access, the driver MUST use 8-bit wide accesses for 8-bit wide fields, 16-bit wide

	and aligned accesses for 16-bit wide fields and 32-bit wide and aligned accesses for 32-bit and 64-bit wide

	fields. For 64-bit fields, the driver MAY access each of the high and low 32-bit parts of the field independently.

9p was never standardized, but the linux header at least lists it as
follows:

struct virtio_9p_config {
        /* length of the tag name */
        __virtio16 tag_len;
        /* non-NULL terminated tag name */
        __u8 tag[0];
} __attribute__((packed));

In that sense tag is an 8 byte field.

So which guest reads tag using a 32 bit read, and why?



> > - access returns -1
> >
> 
> The access will be split into 2 accesses, either by hardware or
> software. On RISC-V such unaligned access is emulated by M-mode
> firmware. On ARM I believe it's supported by the CPU. So the first
> converted aligned access is to read 4 byte at 0x14 and the second
> converted aligned access is to read 4 byte at 0x16, and drop the bytes
> that are not needed, assemble the remaining bytes and return the
> result to the guest software. The second aligned access will fail the
> sanity check and return -1, but not the first access, hence the result
> will be `p9\377\377`.
> 
> >
> > What I find confusing in the above description:
> > - reference to unaligned access - I don't think these
> >   are legal or allowed by QEMU
> > - reference to `p9\377\377` - I think returned value will be -1
> >
> 
> Regards,
> Bin


