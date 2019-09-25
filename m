Return-Path: <SRS0=SZz4=XU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85C68C432C1
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 08:44:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 56F5620872
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 08:44:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56F5620872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47194 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iD2uk-0002Yb-LS
	for qemu-devel@archiver.kernel.org; Wed, 25 Sep 2019 04:44:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55176)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <slp@redhat.com>) id 1iD2t1-0000vJ-Q3
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 04:43:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <slp@redhat.com>) id 1iD2t0-0005RR-PI
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 04:42:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43250)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <slp@redhat.com>) id 1iD2t0-0005QY-HA
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 04:42:58 -0400
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 95B324E92A
 for <qemu-devel@nongnu.org>; Wed, 25 Sep 2019 08:42:57 +0000 (UTC)
Received: by mail-wr1-f72.google.com with SMTP id j3so1975292wrn.7
 for <qemu-devel@nongnu.org>; Wed, 25 Sep 2019 01:42:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version;
 bh=DSLVV75qLw+0N8nWOMHDHQtfO/A+RcSSsvRG5jZ6FLE=;
 b=kSrz/cFCzwFdauCT2cFf/fSqdfqb61hhoXKPNigJU/nEVuqTCMe5z1d0HWDB9/PMYT
 84ZU8NqobWLrMqH+DS4gX3DhhnqgtdoC7qeymwNdGi3ONicwueU9J294zwyZeyfq5hnX
 p1jBS9wGnjYts9PgXibdab+nZ5hrK2X+sVM/U5CH5ZixGc/6tnH/GJ4FBfrSREAgng6G
 +JADrH7cmZOvPaSc4ou3fq1AbAln4JR+/B1MtX7naRyXOP3RL/+Y4PA2ZeZ76t2B36oE
 dKdp5kwZht9q9DKadhEZNlP+crJ/mEK8CB5BowH/+cuMXgcdgNooxEROWw6pw0znBt7X
 QUqw==
X-Gm-Message-State: APjAAAUTaJTY6I1W0v2EKmihY/ywhsq9WD8TJEKTwS8tT9JADQ3Fp7kB
 2fVistAOpcdjT9W07lnVU9W+IqzLwxDNvJieDh4I/Y5r0gPFbamk9rZsY9aGH0OSdrKvbQd9RNQ
 6ZsEdGRGh9narY40=
X-Received: by 2002:a5d:408c:: with SMTP id o12mr8297682wrp.312.1569400976328; 
 Wed, 25 Sep 2019 01:42:56 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzny/fqoh9pLCUGBbConFyB9yzWPkbpAcxV4AFu5NCBiaU62CK8YJ+1ObNq5HuPImpCnplucw==
X-Received: by 2002:a5d:408c:: with SMTP id o12mr8297661wrp.312.1569400976138; 
 Wed, 25 Sep 2019 01:42:56 -0700 (PDT)
Received: from dritchie.redhat.com (139.red-95-120-215.dynamicip.rima-tde.net.
 [95.120.215.139])
 by smtp.gmail.com with ESMTPSA id r20sm7242022wrg.61.2019.09.25.01.42.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Sep 2019 01:42:55 -0700 (PDT)
References: <20190924124433.96810-1-slp@redhat.com>
 <c689e275-1a05-7d08-756b-0be914ed24ca@redhat.com> <87h850ssnb.fsf@redhat.com>
 <b361be48-d490-ac6a-4b54-d977c20539c0@redhat.com>
User-agent: mu4e 1.2.0; emacs 26.2
From: Sergio Lopez <slp@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v4 0/8] Introduce the microvm machine type
In-reply-to: <b361be48-d490-ac6a-4b54-d977c20539c0@redhat.com>
Date: Wed, 25 Sep 2019 10:42:53 +0200
Message-ID: <87ef04sr5e.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
 micalg=pgp-sha256; protocol="application/pgp-signature"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: Pankaj Gupta <pagupta@redhat.com>, mtosatti@redhat.com, ehabkost@redhat.com,
 kvm@vger.kernel.org, mst@redhat.com, lersek@redhat.com,
 David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org, kraxel@redhat.com,
 imammedo@redhat.com, philmd@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--=-=-=
Content-Type: text/plain


Paolo Bonzini <pbonzini@redhat.com> writes:

> On 25/09/19 10:10, Sergio Lopez wrote:
>> That would be great. I'm also looking forward for virtio-mem (and an
>> hypothetical virtio-cpu) to eventually gain hotplug capabilities in
>> microvm.
>
> I disagree with this.  virtio is not a silver bullet (and in fact
> perhaps it's just me but I've never understood the advantages of
> virtio-mem over anything else).
>
> If you want to add hotplug to microvm, you can reuse the existing code
> for CPU and memory hotplug controllers, and write drivers for them in
> Linux's drivers/platform.  The drivers would basically do what the ACPI
> AML tells the interpreter to do.
>
> There is no reason to add the complexity of virtio to something as
> low-level and deadlock-prone as CPU hotplug.

TBH, I haven't put much thought into this yet. I'll keep this in mind
for the future.

Thanks,
Sergio.


--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEvtX891EthoCRQuii9GknjS8MAjUFAl2LKI0ACgkQ9GknjS8M
AjUOcw//asDU7g+IT2n1QL1G8ghvi8LC72TH/OKWfz+/vM87Ew67KKFspC7j9M2m
YzudkTR2GElf077XpYnHyKyPNX49f8DntNAn6ujj28U+/Hxmn3cMC5g50/+n4NYF
pY6pRX60uNRD11PsM+jWy6az/NwZevef9SPiZ5W5BCJ4ewPid+3rwyhKLNijIZq0
0f9LjQHONB5uI4P5pZtEN3Dt7bLueh4Galn0KxrsD7lqLPVZAfqWI0d0lK59B3hQ
RP2WErMfdq118/Yv9PAaCLc7D3zEyqJt9PfWaeK4ceWxqWu9XyHmzZpWWdhgxCF3
3Yb2zsDhPka+TrpfVtGGRIjOi3R06+8jLjyVxdN2tVB3qjaNlW3fJYes9aY2ojBT
JSAw62meToMHTER7fT3CBor7clPJDWnxUP4X053CGjXIJvzyeuDTDwxPDx/5VSZN
6v5hhwapFsO08HNsD0UqurpoKhH5a2xsbqVL06HTyjk4hJpVPHTwUoeYjzJN5dm6
q52DScdxz78bXqfYKg/5Ej+W3aOKoBwedWEYt9JZpmlzXZVmGN9Cg/naL/9fKSS4
tVcIJ9rnn1/2HJAO1XHLb9iuiDCHYI7Nr6nlnpPrRF1MRj75J3kClrXW4w3T0EiB
BNPNeYqU4XJb8j5Z7SACRNhLz/aUSjvP+yhVBQC/GabJtWK/h/0=
=QDtu
-----END PGP SIGNATURE-----
--=-=-=--

