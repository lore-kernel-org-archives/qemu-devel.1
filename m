Return-Path: <SRS0=i8Yf=47=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04FB2C0044D
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Mar 2020 20:49:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB5312071B
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Mar 2020 20:49:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NdHiRheB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB5312071B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48198 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDDiR-0004Cm-PS
	for qemu-devel@archiver.kernel.org; Sat, 14 Mar 2020 16:49:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44523)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1jDDhn-0003hc-R8
 for qemu-devel@nongnu.org; Sat, 14 Mar 2020 16:48:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1jDDhm-0003V4-Cc
 for qemu-devel@nongnu.org; Sat, 14 Mar 2020 16:48:23 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:36716
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1jDDhm-0003Sg-8C
 for qemu-devel@nongnu.org; Sat, 14 Mar 2020 16:48:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584218901;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iAxXpPPeFK3SIRsOqup1qcd6VaqZUEFs2Ih414MfK4c=;
 b=NdHiRheBb1Qza2uJc37ccqhf1OPc82rhmUYWecGYMXh3TmQGpwHLH3p38ZS3ZwupFY7onZ
 6gTvvSOzqpv21CqugeKz4X+lHKwun2QvB+HKYVAghynKn/IX/BKRIsADzD1GYB/vtHeN8a
 4EssdsCNxePwjqn9YCH7vQWSAZw982k=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-365-XDItSyGoPEmdeNcPG0zneQ-1; Sat, 14 Mar 2020 16:48:18 -0400
X-MC-Unique: XDItSyGoPEmdeNcPG0zneQ-1
Received: by mail-qt1-f197.google.com with SMTP id k20so12216249qtm.11
 for <qemu-devel@nongnu.org>; Sat, 14 Mar 2020 13:48:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=BwVHJNoMVG1nZn7dvG+7MEZvPMuWSS7I3CFnDRNm83U=;
 b=EEoBmTJ5p6kEk3K5dRfYyoXiBd0vEaZX/WvBOPsQTZmiXiMfagySp8e4mQqNzXyvri
 +t874l42VZi4P7bfT8iiBPsYih+ckNxd8kJ5IbVEik+shxa5X7drPtEZ7ZVVD/D9G78t
 6uJl+J8hiFrCmi3z/N3A8q0kfDqtf5swMHcnpCscFWO1/ZtEbjxtoO5kp3sUB/pVU1ff
 RZtv65n89vCw+QGXUpbKmMX0ou/IgDIXx97BI/tjTzBLookiKa+KhCMVz52V3YihOH1p
 oknB/ot7iI6eNG/J5DLL6m2EyGWfgz7819aEPk3+LU3J+AC5lxf5jUYfIH/J4eW2H7mV
 8vxg==
X-Gm-Message-State: ANhLgQ3PbpKTFCeNWMRLI+tQyOD6jHunl4tay7sFRrQIQBnJJ4fP0s6x
 D4xc9azl1tlNaNd8i9JHpbACZVAG5+4zVrKO0jzfmBQsLg0LJmt/zpoyoz22JBhw2/n85KPD6Yg
 HyhGm/E+vsK3DmmA=
X-Received: by 2002:ac8:6b54:: with SMTP id x20mr18775511qts.41.1584218897901; 
 Sat, 14 Mar 2020 13:48:17 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vtiXwrdNsRx2P/KEKNwj4iMnQmJC2w1evYb9dqKbpy1OiMSzLzK40bI1o7JusQcmtkRpE4l9g==
X-Received: by 2002:ac8:6b54:: with SMTP id x20mr18775501qts.41.1584218897641; 
 Sat, 14 Mar 2020 13:48:17 -0700 (PDT)
Received: from redhat.com (bzq-79-180-7-202.red.bezeqint.net. [79.180.7.202])
 by smtp.gmail.com with ESMTPSA id
 d72sm11876895qkg.102.2020.03.14.13.48.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 14 Mar 2020 13:48:16 -0700 (PDT)
Date: Sat, 14 Mar 2020 16:48:11 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Nikita Leshenko <nikita.leshchenko@oracle.com>
Subject: Re: [PATCH v3 10/16] hw/i386/vmport: Add support for CMD_GETTIME
Message-ID: <20200314162920-mutt-send-email-mst@kernel.org>
References: <20200312195652-mutt-send-email-mst@kernel.org>
 <0bc7dac9-41a6-5af2-a1d5-ef1e79f92eea@oracle.com>
 <20200313113049-mutt-send-email-mst@kernel.org>
 <3c0d9308-f56c-0766-9815-241a28d9a246@oracle.com>
 <20200313170914-mutt-send-email-mst@kernel.org>
 <67d158f3-9d6c-cba8-6b3a-87702abdc6f0@oracle.com>
 <20200314151236-mutt-send-email-mst@kernel.org>
 <a9ac1106-67be-5d5d-fd30-669a483f09b0@oracle.com>
 <20200314152119-mutt-send-email-mst@kernel.org>
 <C3D0DD6C-592E-4230-A7D6-FF423265DF03@oracle.com>
MIME-Version: 1.0
In-Reply-To: <C3D0DD6C-592E-4230-A7D6-FF423265DF03@oracle.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: ehabkost@redhat.com, qemu-devel@nongnu.org,
 Liran Alon <liran.alon@oracle.com>, pbonzini@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, Mar 14, 2020 at 09:58:23PM +0200, Nikita Leshenko wrote:
> I think that the reason that open-vm-tools doesn't move time backwards is=
 to
> help applications that treat wallclock time as if it's monotonic time and=
 break
> if the date is moved backwards (which may happen more frequently in virtu=
al
> environment so it's handled specifically). But this doesn't change the fa=
ct that
> this PV interface is for reporting wall time.
> So I couldn't understand what
> source other than gettimeofday() you were suggesting for Liran to use to =
report
> wallclock time.

Some kind of offset to wallclock time I'm guessing. For example,
we could save wall clock on vm save, and if it goes
backwards on vm load, add an offset.

--=20
MST


