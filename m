Return-Path: <SRS0=2jXw=3K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50020C33CAA
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 09:17:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E17424125
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 09:17:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UerU2/1s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E17424125
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50332 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itpey-00080c-Ly
	for qemu-devel@archiver.kernel.org; Tue, 21 Jan 2020 04:17:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57039)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1itpdH-0006bV-K4
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 04:15:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1itpdD-0004NA-Vc
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 04:15:35 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:22468
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1itpdD-0004Mu-Qx
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 04:15:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579598131;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Md8V2Ky0kTvBvyO34O3k/QIMfoTv1q1MIBfAVqA70wA=;
 b=UerU2/1sTS1RLwGPfF0OkcP3vvsnL1GTlSy3h2A9AAbG89cmn3dR6LhSBXZ4940n24/HKT
 OBkb0/xOkGpV/vcGjmLER3F0yddVmv9ksCfhlhAmrNODSOXhSlwurybpJxLYSwP1vQdr5B
 eS84mbvFis8IJqvPYeuW/3gMJ25XYpc=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-342-RoTxQwpcOh63_u81xDsDOQ-1; Tue, 21 Jan 2020 04:15:29 -0500
Received: by mail-wm1-f71.google.com with SMTP id c4so367269wmb.8
 for <qemu-devel@nongnu.org>; Tue, 21 Jan 2020 01:15:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:to:from:subject:message-id:date:user-agent
 :mime-version:content-language:content-transfer-encoding;
 bh=Md8V2Ky0kTvBvyO34O3k/QIMfoTv1q1MIBfAVqA70wA=;
 b=E4lIZKecoGFVZvrleasHFJneGus7YhKjHkyHBNg4UN0P1tFLgSFiMNl5r21V2G14aG
 k7EgPNFonH7rOgRy5K3o/FjTe34B615YnpTmlVOYkXAuWwU2n0F4Vj+ut746OdIReZoP
 Y3u7Xlz9VonaMtV6P2/1pPSSwy68BFG+KpKnW3hX93YbXm9xdd4xbzOncAYJ1YE3x8d8
 BosVWDIfy5KPSvTW4WQwy2jIzKXOOgupV61ommKwo8t82K9nHJ03LO9o8ljef+AoNNc3
 d2s2FkdYlvA0DnVzrsJcd9NI3qwAedVfPHdzpPIVA07qJ9pi35fdI/kVchxKiRKzQWXL
 bMPA==
X-Gm-Message-State: APjAAAXxvdih+3loeD3X2rtvJbCqpGE5J/vwOSUG9fmxrIOR3HyuNVzZ
 E+sNlG3tWAOBbl0c1vVd4F7a5aEtDruDKcQknCYGA7S0KlEzFmCjZFbz2BpUTBYtBYREZwt9X95
 Xbon7xKrAzQRychY=
X-Received: by 2002:a5d:608e:: with SMTP id w14mr4049004wrt.256.1579598128317; 
 Tue, 21 Jan 2020 01:15:28 -0800 (PST)
X-Google-Smtp-Source: APXvYqw1LzXo34K3/O6aYPjuBL/R1rw12tehBXj+H6cUrJCtkcLfFUxXUvZjFjKoEPZ6anrD/rBCeg==
X-Received: by 2002:a5d:608e:: with SMTP id w14mr4048966wrt.256.1579598127932; 
 Tue, 21 Jan 2020 01:15:27 -0800 (PST)
Received: from [192.168.1.35] (113.red-83-57-172.dynamicip.rima-tde.net.
 [83.57.172.113])
 by smtp.gmail.com with ESMTPSA id v22sm2978727wml.11.2020.01.21.01.15.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Jan 2020 01:15:27 -0800 (PST)
To: avocado-devel <avocado-devel@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Subject: How to set a limit and clear Avocado cache?
Message-ID: <de831637-040b-d182-2f46-e833fead575b@redhat.com>
Date: Tue, 21 Jan 2020 10:15:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
Content-Language: en-US
X-MC-Unique: RoTxQwpcOh63_u81xDsDOQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hello,

Today I ran out of space in my /home, I ran the 'baobab' tool and while 
the first bigger directory was obvious to me (~/.ccache), the second 
wasn't: ~/avocado/data/cache/by_location/, with various GiB.

Note, this directory is not listed in my config...
$ avocado config | fgrep ${HOME}/avocado
$

I might already have asked on qemu-devel mailing list, but is there a 
way to set a particular location for the cache directory, different than 
my data directory where I keep the job-results log files?

 From the doc, get_cache_dirs() "Returns the list of cache dirs, 
according to configuration and convention" but doesn't explain how to 
configure it:
https://avocado-framework.readthedocs.io/en/75.1/api/core/avocado.core.html#avocado.core.data_dir.get_cache_dirs

I searched if there was an Avocado command displaying cache use, and to 
eventually flush it, like ccache --cleanup/--clear options, but couldn't 
find any, so I ended calling a rmdir ~/avocado, which I know it is not 
correct, but saved me some headaches.

Is there a clean way to do this?

I see the clean_tmp_files() function, but no equivalent for the cache:
https://avocado-framework.readthedocs.io/en/75.1/api/core/avocado.core.html#avocado.core.data_dir.clean_tmp_files

Bonus question, can I set a size limit for the cache directory?

Thanks,

Phil.


