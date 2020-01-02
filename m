Return-Path: <SRS0=Q/S9=2X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECD34C2D0DC
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jan 2020 15:29:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B7CF820848
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jan 2020 15:29:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gLK2y5pP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7CF820848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42114 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1in2PQ-0004hb-Rd
	for qemu-devel@archiver.kernel.org; Thu, 02 Jan 2020 10:29:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50159)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1in2Ny-0003gq-JY
 for qemu-devel@nongnu.org; Thu, 02 Jan 2020 10:27:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1in2Nw-0007S0-D4
 for qemu-devel@nongnu.org; Thu, 02 Jan 2020 10:27:41 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:43123
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1in2Nw-0007Qg-0p
 for qemu-devel@nongnu.org; Thu, 02 Jan 2020 10:27:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1577978859;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NjjrMhPf+iPAqNAB3S/XX9ODs4o2j3AOKMYdcRzMJRo=;
 b=gLK2y5pPsX7lTWcpBKknAsJutZJfv7bbNveVbgSkWVft6Y/YF7TQ5E5NYq6pfXPN2S2aXD
 SEhC9R1bw9rnfYiAj6o+oZK9hXTXE8XMgN7LAAdhNbBTGEIkoeP7dRmonMEwJuEQMgTRRZ
 aV7vgZCIsPhdylHTOSsukJmm230jMYY=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-4-fKHttp3DPF2YqElIxpBP7A-1; Thu, 02 Jan 2020 10:27:37 -0500
Received: by mail-wr1-f70.google.com with SMTP id c17so15598213wrp.10
 for <qemu-devel@nongnu.org>; Thu, 02 Jan 2020 07:27:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=MmPQx5rqx5VgdbOzpzxLpAnikFM0Wjjq49uXrt3noWA=;
 b=lHWeihPqWoXlrwU/uv7CjDC1khN9eTI0wFmHdPuql+mqdPCd2nHv0Slhgnqr+UDgFr
 Vp0ULr6KNP8vZAShBSJReUYrOE40OixF80TKnulR4ixcf2JJDZaBYUodoxOcAV+HZxAh
 voQZlOGh3hrIsOI4AqlGpwQg/34UPstCbAS+i9OwQ9TfX/UcSkDQ8kTzD26vdQ9P+lIt
 J9pWQMap9o+zS8OvAdqck6lNyRHVKXAQYN0JaZxj3yr8iEzmWe+19IE6aMIjcqusAE5N
 lwJRA4q+SrC2TIRwFEUEF6STR7jx6AHmDrNuJQkucTaijyxjwxAf5o3STpbOhbMVsoW+
 Aojw==
X-Gm-Message-State: APjAAAUQ5KfRd+LZH4apaJdLxMyiDX8KW87wCcZXcxXwQkeT7vV/MtI/
 t6F4RoxYHboaX3aSps6V+0+L5gNFM8F+zku++zG9j8RjOP6EOtZkHhOSs5Jmh9BnIj884xV/5lX
 2c9JHkLnM+yPGsa4=
X-Received: by 2002:a5d:6346:: with SMTP id b6mr81947209wrw.354.1577978855653; 
 Thu, 02 Jan 2020 07:27:35 -0800 (PST)
X-Google-Smtp-Source: APXvYqw+UkhzUsRoQc8X+sriAqk9ETwkLh1BzcEp6U9fqKUqYJzFoJzFEey1PzVh0ZUpzaAqnAzudg==
X-Received: by 2002:a5d:6346:: with SMTP id b6mr81947197wrw.354.1577978855502; 
 Thu, 02 Jan 2020 07:27:35 -0800 (PST)
Received: from [192.168.50.32] (243.red-88-26-246.staticip.rima-tde.net.
 [88.26.246.243])
 by smtp.gmail.com with ESMTPSA id f1sm55981549wro.85.2020.01.02.07.27.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 02 Jan 2020 07:27:35 -0800 (PST)
Subject: Re: GraphViz extension on QEMU Wiki
To: Stefan Hajnoczi <stefanha@gmail.com>
References: <b4291830-5edd-5f7e-6170-63e43b6e629d@redhat.com>
 <20200102150933.GP121208@stefanha-x1.localdomain>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <2a658dcc-0004-d127-f4dc-1d380eaa1223@redhat.com>
Date: Thu, 2 Jan 2020 16:27:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200102150933.GP121208@stefanha-x1.localdomain>
Content-Language: en-US
X-MC-Unique: fKHttp3DPF2YqElIxpBP7A-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
Cc: Jeff Cody <codyprime@gmail.com>, qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/2/20 4:09 PM, Stefan Hajnoczi wrote:
> On Thu, Dec 26, 2019 at 07:05:04PM +0100, Philippe Mathieu-Daud=E9 wrote:
>> I'm not sure who is responsible of this...
>=20
> Jeff maintains the web server and wiki.
>=20
> I can look into things when Jeff is too busy, but lets see if he has
> time in January.

Sure no problem this is not urgent, this is to improve some=20
documentation and add GSoC ideas.

Thanks.


