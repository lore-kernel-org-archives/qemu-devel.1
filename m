Return-Path: <SRS0=BVCf=4W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95DC1C3F2D1
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 10:38:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D977208CD
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 10:38:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VnAQR8Iu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D977208CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46900 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9ntg-0005dP-FN
	for qemu-devel@archiver.kernel.org; Thu, 05 Mar 2020 05:38:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47866)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j9nso-0004kn-28
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 05:37:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j9nsm-0001JW-Na
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 05:37:37 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:45953
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j9nsk-0001FZ-DL
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 05:37:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583404649;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=W1jtqUOiDyJWfbsH0y3MGloQy0LFzf5sRFvE+Olrdxk=;
 b=VnAQR8IuoM2dz/LGi2EYLwyoU5svqQCPJNjhzpYYEfIRIPivY5OdGlj/nR0b/awuVqaRDp
 mu3U21sfZ/KTex26XJXlYkE+5A7eFbdZmNK46fi6uW+86KAXaL0Sw9xp2zz8qdh7knLrIG
 2lv8tiXPdUbsGSG9wnlcUelUjyZf458=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-20-e3Av0MGuNu2aAEftQ9WSMQ-1; Thu, 05 Mar 2020 05:37:26 -0500
X-MC-Unique: e3Av0MGuNu2aAEftQ9WSMQ-1
Received: by mail-ed1-f70.google.com with SMTP id a11so2636866eds.15
 for <qemu-devel@nongnu.org>; Thu, 05 Mar 2020 02:37:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=N+cxLmP08Sog3fQ2kUzzCL1tQJ8Fhjt86s7D+fDGMR8=;
 b=bxLiIw6/YmljVKBvGO5wm5PbW7zqX6Sx+5yDAbW6aK90WPdAjr5CokJ8ahzaBvP49m
 v/hMYTJTAXgDtrlGpVQ8c2kxBniH5t3Ei8fz+pQ2Gn67ykyQHkfFsOA3kNrXKkPVMgYr
 JuPHMu3Njh0FTH8AyCBXoQ9X101VmAVN8yucNg0mQQwnUb4Bc1DCLuuoadOBwIwDq3b3
 tjbwpfaaobVIz8SMKEz/jwWfn6WCWsSNB4ikyfLzBbpaU/hjUVAqORR0BI7zYTE26vET
 7t3/jYnHJdLPwS4uQeVixHZ6LQGqqyUqtYhPCCW6gsMnO9vqew2lUxhoyxkONRdt4KzU
 esyQ==
X-Gm-Message-State: ANhLgQ1VK42TXTdGi6JyXOTdN4fm+FWUeRpzVAoTv2zdw7wsehFNBM+j
 rgoLWsRdL2R38SDBWL7Rp5/WzLfALMsI1Q7eh6IWWWKtyzEmVYA7g0d1D3PQn7Z2dkYWnf9b5gw
 ZNUgiZuaNL7jWCOA=
X-Received: by 2002:a17:906:970f:: with SMTP id
 k15mr6706512ejx.334.1583404644812; 
 Thu, 05 Mar 2020 02:37:24 -0800 (PST)
X-Google-Smtp-Source: ADFU+vvA4U4MgmVJt4DZ4gjM43QVnANIvUnYIs48IrIZkKZWBuoGAgvMpdHBwiXxpkWQqKN8WOgpog==
X-Received: by 2002:a17:906:970f:: with SMTP id
 k15mr6706497ejx.334.1583404644603; 
 Thu, 05 Mar 2020 02:37:24 -0800 (PST)
Received: from [192.168.1.35] (47.red-88-21-205.staticip.rima-tde.net.
 [88.21.205.47])
 by smtp.gmail.com with ESMTPSA id b23sm436021ejq.84.2020.03.05.02.37.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Mar 2020 02:37:24 -0800 (PST)
Subject: Re: [PATCH 0/3] hw/net,virtfs-proxy-helper: Reduce .data footprint
To: Stefano Garzarella <sgarzare@redhat.com>
References: <20200305010446.17029-1-philmd@redhat.com>
 <20200305095357.nvhjz7q7tuquys4k@steredhat>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <8488759c-022a-1c74-c9a1-ad223959494b@redhat.com>
Date: Thu, 5 Mar 2020 11:37:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200305095357.nvhjz7q7tuquys4k@steredhat>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: Dmitry Fleytman <dmitry.fleytman@gmail.com>, qemu-trivial@nongnu.org,
 Jason Wang <jasowang@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>, qemu-devel@nongnu.org,
 Greg Kurz <groug@kaod.org>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/5/20 10:53 AM, Stefano Garzarella wrote:
> On Thu, Mar 05, 2020 at 02:04:43AM +0100, Philippe Mathieu-Daud=C3=A9 wro=
te:
>> More memory footprint reduction, similar to:
>> https://lists.gnu.org/archive/html/qemu-devel/2020-03/msg00984.html
>>
>> The elf-dissector tool [1] [2] helped to notice the big array.
>>
>> [1] https://phabricator.kde.org/source/elf-dissector/
>> [2] https://www.volkerkrause.eu/2019/06/22/elf-dissector-aarch64-support=
.html
>>
>=20
> Thanks to share these links!

FYI the heap equivalent (besides that more powerful) is:
https://github.com/KDE/heaptrack

>=20
>> Philippe Mathieu-Daud=C3=A9 (3):
>>    hw/net/e1000: Add readops/writeops typedefs
>>    hw/net/e1000: Move macreg[] arrays to .rodata to save 1MiB of .data
>>    virtfs-proxy-helper: Make the helper_opts[] array const
>>
>>   fsdev/virtfs-proxy-helper.c | 2 +-
>>   hw/net/e1000.c              | 6 ++++--
>>   hw/net/e1000e_core.c        | 6 ++++--
>>   3 files changed, 9 insertions(+), 5 deletions(-)
>>
>=20
> Cool and clear changes!
>=20
> Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
>=20
> Thanks,
> Stefano
>=20


