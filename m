Return-Path: <SRS0=cpkI=BC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32062C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 13:48:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EFDDC20759
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 13:48:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FCQhXopA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFDDC20759
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48184 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jybaK-0000fA-70
	for qemu-devel@archiver.kernel.org; Thu, 23 Jul 2020 09:48:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60720)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vkuznets@redhat.com>)
 id 1jybZ2-00081m-IW
 for qemu-devel@nongnu.org; Thu, 23 Jul 2020 09:47:12 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:45870
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <vkuznets@redhat.com>)
 id 1jybZ1-0000Pe-00
 for qemu-devel@nongnu.org; Thu, 23 Jul 2020 09:47:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595512030;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Wi3XwguH+rI7xDFElNuMYvAwVhlDfJK/ugZeJP9B8dk=;
 b=FCQhXopAsXbAmEBLEQoRGxYKYBxX2A6rQXn86eVNEtKmlbp1hzg+uhZZpf4Ec2VJ7vc6hM
 pwQP1ZOJFRRTWe2HZTbsbMfSXjuJG/M/gl6T2qrVlEQTBBA7hr9yp+NdTm7nk/IBHE9iF8
 LxU8lr0GMPfO/uV0LDz+yFzQs+mQNUo=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-389-BFitADnRPH25FGfhgM87RA-1; Thu, 23 Jul 2020 09:47:06 -0400
X-MC-Unique: BFitADnRPH25FGfhgM87RA-1
Received: by mail-ej1-f71.google.com with SMTP id gv21so2421513ejb.8
 for <qemu-devel@nongnu.org>; Thu, 23 Jul 2020 06:47:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
 :message-id:mime-version;
 bh=Wi3XwguH+rI7xDFElNuMYvAwVhlDfJK/ugZeJP9B8dk=;
 b=AEdGUiclInAuLN0UU8+4/IoPZkugvqbkfTOfqqGIlyJ0WmusOU5ZWVAhhMCNlUZyr6
 G0qT3DA1fVzo2V8nZxnngblqetzHJKSR+miCp8XRwGLhlG+W2G1Q5nwEwFOP7o0gJakb
 j2S1WpQ7zfG3vzI5Ni3F+TO6Xbjh3OKisJOI/pb6StoxGDG3Jcp9KXLlWNAhb4htkHQk
 O/sf/FggUeUkXiGKv/90X8McsbdfMah6EPv39VLId0TGsgPDutOHyKeup/0U4i20yvnE
 caI+43qShmW3G4xT3ADJ44W0g1/fS8nGC5pgfyLnrars8RnzLrVOxhonEv/dpOj+lQRf
 DdBQ==
X-Gm-Message-State: AOAM532DuWwON8ZFhSWH2H0Abx8tJ973yMxZTdDjcQ0/Sc9dAMQGqQBZ
 p1O2jxi9MWd41ZN1zJrcwVKzTrUky8VvBPlqjL0/Y2o8P/OJoQGiFqFIH79ittFQhci7tztA+YC
 y7yB17AJfQgH6I9E=
X-Received: by 2002:a17:906:3e54:: with SMTP id
 t20mr4315186eji.471.1595512025330; 
 Thu, 23 Jul 2020 06:47:05 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw9WtnQy0mLJVorxpnlLK/GYBTRMKoeUE/LoxNg45YsIDqlUH3e12y/mPkPHx5t0zHMijQ6ew==
X-Received: by 2002:a17:906:3e54:: with SMTP id
 t20mr4315163eji.471.1595512025154; 
 Thu, 23 Jul 2020 06:47:05 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
 by smtp.gmail.com with ESMTPSA id oz7sm2063028ejb.96.2020.07.23.06.47.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jul 2020 06:47:04 -0700 (PDT)
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: 5.1.0-rc1 regression: reset fails with kvm and -cpu host
In-Reply-To: <CABgObfZZCPGq9-G8aP9+6X1kxCfPFy9Kbfgq8FUsNKLdxOfLpQ@mail.gmail.com>
References: <bf007af9-f81e-3542-0237-5ea467f34377@siemens.com>
 <20200722173513.GO1274972@habkost.net>
 <7be95bd6-dfc6-2c22-85a1-a1c932d07fdd@siemens.com>
 <20200722204731.GP1274972@habkost.net> <20200722212159.GQ1274972@habkost.net>
 <20200723084026.GB2622@work-vm>
 <3eba2f87-5527-bd7c-2eb7-ce67cb32d9ef@redhat.com>
 <87pn8mo20i.fsf@vitty.brq.redhat.com> <20200723125223.GI2621@work-vm>
 <60af679d-8c7d-cc37-344b-79aa193df166@siemens.com>
 <87mu3qnz00.fsf@vitty.brq.redhat.com>
 <CABgObfZZCPGq9-G8aP9+6X1kxCfPFy9Kbfgq8FUsNKLdxOfLpQ@mail.gmail.com>
Date: Thu, 23 Jul 2020 15:47:03 +0200
Message-ID: <87k0yuny20.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Received-SPF: pass client-ip=207.211.31.120; envelope-from=vkuznets@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/22 22:13:02
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: qemu-devel <qemu-devel@nongnu.org>, Jan Kiszka <jan.kiszka@siemens.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Paolo Bonzini <pbonzini@redhat.com> writes:

> Yes, that seems correct.
>

Thank you!

It seems we also need to not reset HF2_GIF_MASK in
kvm_get_nested_state() when !svm and KVM_STATE_NESTED_GIF_SET is missing
(as nVMX doesn't set it). I'll be sending the patch shortly.

-- 
Vitaly


