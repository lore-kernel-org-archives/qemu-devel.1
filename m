Return-Path: <SRS0=p7gi=6J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EEFCC55185
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Apr 2020 10:47:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 09E1420714
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Apr 2020 10:47:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZE/6JJ25"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09E1420714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34480 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jSILN-00030c-38
	for qemu-devel@archiver.kernel.org; Sat, 25 Apr 2020 06:47:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40618)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1jSIKR-0002Tw-SM
 for qemu-devel@nongnu.org; Sat, 25 Apr 2020 06:46:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1jSIKR-0000wF-2q
 for qemu-devel@nongnu.org; Sat, 25 Apr 2020 06:46:35 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:59997
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jSIKQ-0000od-F2
 for qemu-devel@nongnu.org; Sat, 25 Apr 2020 06:46:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587811592;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=a4A+lrdI1dFhVegHcBQe60sNI1hR1+hKm0XsksZ6haE=;
 b=ZE/6JJ25gF2GHZrgxAAMaPSojtqWCZtrBVNYO0Ged0bpNAgu0PfPsLPgojlzVl5xVrQbno
 xEGNIcNItSlXst0H9RkvUuq1nMsoJCPGFTmZ2O7c/0oQsTsDMSSHpxktpMy3HQEftpJYo5
 Ic/ru0VSbbo0WQJqiNYrtYZtyrSEgg4=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-79-ctXrWRzpPbG7aWeB6Fkq7A-1; Sat, 25 Apr 2020 06:46:31 -0400
X-MC-Unique: ctXrWRzpPbG7aWeB6Fkq7A-1
Received: by mail-wr1-f69.google.com with SMTP id u4so6534336wrm.13
 for <qemu-devel@nongnu.org>; Sat, 25 Apr 2020 03:46:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=zutJsnXkVSIqotkfhzRuC9WUfFnFfS8YcXLnqr/eb9g=;
 b=MvVkJAiNhKa+2cxpLv4BBb9HS9fq5z6fKsVPX36NdxFgKzcwihQpXwLOTYqYw+G1m/
 vPR9mP+r8wFHS8i4sq/x+KX4Uyr2ndNUi1y+TpcYIunrF1j6zBpc8GLdqcuaMOg1NPDf
 fvrAgEbJEpRwM2v/ZMBaVURbyF0KojS4zokaXJvmL+LCiEBnwwwwtmm+0fbyLXTnslZW
 LUSR/qqMwSxFmG4O8FH19Nsvel+/IgW6Skpk89XTbKM9y/c8eq0Gm3LGTJK7/K3pqHik
 rKw+OS0cy4KmzdM/XC3OoefJTutERgfLZ6+HkBEG3OXNBON7T7qBR5bA0nBSjzKBy0/u
 dPNw==
X-Gm-Message-State: AGi0PubIWJ4O9lLXlZQCat6dofGAtPz0i/7nUTNR9AnWg8c9LlmkqtWP
 CScflWCyk3VSXM50QBArdP2siF7sO1zWPa/jiG2xrVv4Dvu/wsrm1JWv9vBl6VzcyigKD7jmbAs
 YkkMQ4FF62IqAP7E=
X-Received: by 2002:a1c:8049:: with SMTP id b70mr15489929wmd.162.1587811589912; 
 Sat, 25 Apr 2020 03:46:29 -0700 (PDT)
X-Google-Smtp-Source: APiQypJiCPU199ACMbNMeMy4dwd/mmbtcic4pJKRGyLmUyGPtsYAgvcDuntTjY0J5dKz8uovYH3qUw==
X-Received: by 2002:a1c:8049:: with SMTP id b70mr15489915wmd.162.1587811589699; 
 Sat, 25 Apr 2020 03:46:29 -0700 (PDT)
Received: from [192.168.10.150] ([93.56.170.5])
 by smtp.gmail.com with ESMTPSA id c190sm6789166wme.4.2020.04.25.03.46.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 25 Apr 2020 03:46:28 -0700 (PDT)
Subject: Re: [PATCH v2] chardev/char-socket: Properly make qio connections non
 blocking
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>
References: <1587289900-29485-1-git-send-email-sai.pavan.boddu@xilinx.com>
 <20200420092600.GG346737@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <09893acf-ce13-ce30-79fd-669eded3b7ab@redhat.com>
Date: Sat, 25 Apr 2020 12:46:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200420092600.GG346737@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.81; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/25 06:29:31
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 edgari@xilinx.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 20/04/20 11:26, Daniel P. Berrang=C3=A9 wrote:
> On Sun, Apr 19, 2020 at 03:21:40PM +0530, Sai Pavan Boddu wrote:
>> In tcp_chr_sync_read function, there is a possibility of socket
>> disconnection during blocking read, then tcp_chr_hup function would clea=
n up
>> the qio channel pointers(i.e ioc, sioc).
>>
>> Signed-off-by: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>
>> ---
>> Changes for V2:
>> =09Place the guard around 'qio_channel_set_blocking' call to check conne=
ction status
>> =09This fix is simpler than v1 and explains better about the issue.
>>
>>  chardev/char-socket.c | 4 +++-
>>  1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/chardev/char-socket.c b/chardev/char-socket.c
>> index 185fe38..e56b2f0 100644
>> --- a/chardev/char-socket.c
>> +++ b/chardev/char-socket.c
>> @@ -549,7 +549,9 @@ static int tcp_chr_sync_read(Chardev *chr, const uin=
t8_t *buf, int len)
>> =20
>>      qio_channel_set_blocking(s->ioc, true, NULL);
>>      size =3D tcp_chr_recv(chr, (void *) buf, len);
>> -    qio_channel_set_blocking(s->ioc, false, NULL);
>> +    if (s->state !=3D TCP_CHARDEV_STATE_DISCONNECTED) {
>> +        qio_channel_set_blocking(s->ioc, false, NULL);
>> +    }
>>      if (size =3D=3D 0) {
>>          /* connection closed */
>>          tcp_chr_disconnect(chr);
>=20
> Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
>=20
>=20
> Regards,
> Daniel
>=20

Queued, thanks.

Paolo


