Return-Path: <SRS0=EqPw=EE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70610C2D0A3
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 13:07:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD15C20725
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 13:07:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M4DMHNck"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD15C20725
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47648 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kY7e1-0005Da-Ji
	for qemu-devel@archiver.kernel.org; Thu, 29 Oct 2020 09:07:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35074)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kY7dE-0004mx-Pv
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 09:06:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:52868)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kY7d9-0000bb-KC
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 09:06:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603976775;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3Lv+3hDJ/gfmNc4Vg28z7Fab9P2SUI/z38eUYUEFf6A=;
 b=M4DMHNcknWv0AzkHmpO5TheDqo+mgzJqVkyexkqGenyUCmOouMkmf0kHE4eEROA/DOl44E
 Y5QeGBf2+JCxttteNlGO01OwHEahf80cny3VeGzJ4guwR3NEBNn7L5rieN/Px/sd7mw0Z1
 N4198lPKxnJ1pnGc9Xdm7+nqXBmkQP4=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-383-XWYvmCv_N3mcMQEKw21QmA-1; Thu, 29 Oct 2020 09:06:13 -0400
X-MC-Unique: XWYvmCv_N3mcMQEKw21QmA-1
Received: by mail-wr1-f71.google.com with SMTP id f11so1250897wro.15
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2020 06:06:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=3Lv+3hDJ/gfmNc4Vg28z7Fab9P2SUI/z38eUYUEFf6A=;
 b=Xobk+J3u+/xNfw0sglDcIwLemX5+ayV+xirXA9bON/E7LVdikB+mFaogN8Hz5wGhUC
 Tq4hQ7d8/KBm237y37IL9hVErTQjRdPdOUV6G4CRQicUBXUHIkC9j5sc4ZlhFaYW6/mX
 u8ykfh14anTXqBbBnFXYy20emPKsusMJ6Ew9ZfqrN74y0bR2UEbqqGdAWcTCNtjTERz1
 5jAB3moKELx2aPDkW7hOa7N5DNbsL6S9CWU1zhaonRD54DyO5G2BovyfojRp/dIG32SG
 Xz7fGE7qvxOydWvNmcT3LXHjz7WdODx0+zz2uaIjpo8cU2KelsADi2hCK0L6oio2kyvn
 Hu6g==
X-Gm-Message-State: AOAM533TmW1Y0yvWXNZ3f6ToKWZKj7iY1YoMtudNcSwTSwlF5fcuZxh5
 YBczV50xYdpTx/43X/0BchjiGD90rIxY28i8OK9adaBHKLjciyl9+c6eOxspFVGLu5H6mDvpOWk
 rdblVnXBil1aQT3Y=
X-Received: by 2002:a1c:7d49:: with SMTP id y70mr4350630wmc.103.1603976771301; 
 Thu, 29 Oct 2020 06:06:11 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxquK44tJmrDQuv7Tqk1p21FHEHBvf6UMpq8iVgUPsiJymgrWYY8DwoAEoHWLMI91MG24rU5A==
X-Received: by 2002:a1c:7d49:: with SMTP id y70mr4350532wmc.103.1603976770657; 
 Thu, 29 Oct 2020 06:06:10 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a?
 ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
 by smtp.gmail.com with ESMTPSA id t6sm1620693wrp.68.2020.10.29.06.06.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 Oct 2020 06:06:08 -0700 (PDT)
Subject: Re: Out-of-Process Device Emulation session at KVM Forum 2020
To: Jason Wang <jasowang@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
References: <20201027151400.GA138065@stefanha-x1.localdomain>
 <CAJSP0QWrmNN1Ci-M-4WDFZBOGHyeZvF71utg0w2ajCbOLtynJw@mail.gmail.com>
 <c4e5b631-1607-a0ec-ee88-6c5a9493e3de@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <7977d79c-0e2b-9a71-631e-77811b508bd7@redhat.com>
Date: Thu, 29 Oct 2020 14:06:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <c4e5b631-1607-a0ec-ee88-6c5a9493e3de@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/29 00:47:54
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.261, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
Cc: Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 John G Johnson <john.g.johnson@oracle.com>,
 "mst@redhat.com" <mtsirkin@redhat.com>,
 Janosch Frank <frankja@linux.vnet.ibm.com>, qemu-devel <qemu-devel@nongnu.org>,
 Kirti Wankhede <kwankhede@nvidia.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Yan Vugenfirer <yan@daynix.com>, Jag Raman <jag.raman@oracle.com>,
 Anup Patel <anup@brainfault.org>,
 Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 Roman Kagan <rkagan@virtuozzo.com>, Felipe Franciosi <felipe@nutanix.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Jens Freimann <jfreimann@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Sergio Lopez <slp@redhat.com>,
 Kashyap Chamarthy <kchamart@redhat.com>,
 Darren Kenny <darren.kenny@oracle.com>, Liran Alon <liran.alon@oracle.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 David Gibson <david@gibson.dropbear.id.au>, Kevin Wolf <kwolf@redhat.com>,
 Halil Pasic <pasic@linux.vnet.ibm.com>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 Christophe de Dinechin <dinechin@redhat.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>, fam <fam@euphon.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 29/10/20 14:02, Jason Wang wrote:
> 
> 
> 1) Reading something that is opaque to userspace is probably a hint of
> bad uAPI design
> 2) Did qemu even try to migrate opaque blobs before? It's probably a bad
> design of migration protocol as well.

The nested live migration data is an opaque blob.  The format is
documented by the kernel; for Intel it is also guest-visible.  However
QEMU doesn't try to parse it.

Paolo


