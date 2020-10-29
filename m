Return-Path: <SRS0=EqPw=EE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD177C4363A
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 16:16:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC9CF20756
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 16:16:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=dme-org.20150623.gappssmtp.com header.i=@dme-org.20150623.gappssmtp.com header.b="szutzjLb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC9CF20756
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=dme.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59954 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kYAbL-0003Oo-Ci
	for qemu-devel@archiver.kernel.org; Thu, 29 Oct 2020 12:16:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50726)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dme@dme.org>) id 1kYAaP-0002tz-BD
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 12:15:37 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:43489)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dme@dme.org>) id 1kYAaN-0003jz-Mb
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 12:15:37 -0400
Received: by mail-wr1-x444.google.com with SMTP id g12so3381838wrp.10
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2020 09:15:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dme-org.20150623.gappssmtp.com; s=20150623;
 h=to:cc:subject:in-reply-to:references:from:date:message-id
 :mime-version; bh=dh9IyI2p23eAOqUvdylXgZPVhbK41AleOweQvA3gGOg=;
 b=szutzjLbYanm32i4po/INbZSjaK5A83ci9rE9nr8F1zt9cAnJmbGIhqyY2eK7slpPM
 PViBgKQN9PW/q1BCvtQ/2GPMOb+bk4qI44KeI0yjrijKj4hFDYeB+XERB0NypE4TIocH
 FgtF6fa3ahYM1IzhYongqIE4iDsb7bHCiZpgiroMDIt5+j6lNV2q79W4VPOxiwFUZxXe
 h0ahd37l4pPonq/E6zfJo7O5DKrYwBWdKCS9l8JqbR1QOM+3bQakg9/sHn0j9SbfksiY
 qfw+Ev5zf+42e67q/xBHp2ZtDHtTsJmgGsRrJS2GRhmb11EFlCCN1iBkjOlaVK+l+vGx
 wH8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:to:cc:subject:in-reply-to:references:from:date
 :message-id:mime-version;
 bh=dh9IyI2p23eAOqUvdylXgZPVhbK41AleOweQvA3gGOg=;
 b=S3iCJ7bWEs9q3+viMiDNjaXaKQg0zhzJbqI0IWVU5zRVZ9+1rCG/R/P+HsxRaXSTat
 v660EObPdPnGQq9FiM7QHDPbeurIa7tvxre8BZT1u1qsoIhAubnUY6PMdggU7HK2xLxw
 ArIqFjjx/dZ7fVBqzUo8WDAFtRU+AmenK+le6tYkE/8MztU8zDYigLIyI7vk9QcrvmxF
 veCXfE3M1XgErhrWxPUDYiftT2GhFu6BMbDdzDE0sFQ9Bl/raZQ3eYUkAd7Uwk750p9z
 5GVnAv3tx2FGyDZkfeOgPyrRkB8e15KqcCnoDUSMVCoQnZ+gDlU22zQt0olfrYUqmB/P
 yU1A==
X-Gm-Message-State: AOAM533LaN94/TcLL5FrP/LeHUmnSLWzgiaNpr+mWq9sKVEoFAO+EjW6
 iowVA6wz4AIYqyD7WelHiS8a3w==
X-Google-Smtp-Source: ABdhPJwuwutHSxsc30x0GuYczxoM+ZaGccXfIiHr5yeA360ZWxccCoRRWNh3hVbOmJYbEABo5e52nw==
X-Received: by 2002:adf:906b:: with SMTP id h98mr6532994wrh.310.1603988133155; 
 Thu, 29 Oct 2020 09:15:33 -0700 (PDT)
Received: from disaster-area.hh.sledj.net
 (8.a.e.d.0.0.0.0.0.0.0.0.4.6.0.0.0.4.1.7.1.7.b.b.0.b.8.0.1.0.0.2.ip6.arpa.
 [2001:8b0:bb71:7140:64::dea8])
 by smtp.gmail.com with ESMTPSA id v6sm6341077wrp.69.2020.10.29.09.15.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Oct 2020 09:15:32 -0700 (PDT)
Received: from localhost (disaster-area.hh.sledj.net [local])
 by disaster-area.hh.sledj.net (OpenSMTPD) with ESMTPA id 9182287a;
 Thu, 29 Oct 2020 16:15:31 +0000 (UTC)
To: Jason Wang <jasowang@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: Out-of-Process Device Emulation session at KVM Forum 2020
In-Reply-To: <c4e5b631-1607-a0ec-ee88-6c5a9493e3de@redhat.com>
References: <20201027151400.GA138065@stefanha-x1.localdomain>
 <CAJSP0QWrmNN1Ci-M-4WDFZBOGHyeZvF71utg0w2ajCbOLtynJw@mail.gmail.com>
 <c4e5b631-1607-a0ec-ee88-6c5a9493e3de@redhat.com>
X-HGTTG: vroomfondel
From: David Edmondson <dme@dme.org>
Date: Thu, 29 Oct 2020 16:15:30 +0000
Message-ID: <cunr1ph3t5p.fsf@vroomfondel.hh.sledj.net>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: neutral client-ip=2a00:1450:4864:20::444;
 envelope-from=dme@dme.org; helo=mail-wr1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NEUTRAL=0.779, UNPARSEABLE_RELAY=0.001 autolearn=no autolearn_force=no
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
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Jens Freimann <jfreimann@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Sergio Lopez <slp@redhat.com>,
 Kashyap Chamarthy <kchamart@redhat.com>,
 Darren Kenny <darren.kenny@oracle.com>, Liran Alon <liran.alon@oracle.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 David Gibson <david@gibson.dropbear.id.au>, Kevin Wolf <kwolf@redhat.com>,
 Halil Pasic <pasic@linux.vnet.ibm.com>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 Christophe de Dinechin <dinechin@redhat.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>, fam <fam@euphon.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thursday, 2020-10-29 at 21:02:05 +08, Jason Wang wrote:

> 2) Did qemu even try to migrate opaque blobs before? It's probably a bad 
> design of migration protocol as well.

The TPM emulator backend migrates blobs that are only understood by
swtpm.

dme.
-- 
She's as sweet as Tupelo honey, she's an angel of the first degree.

