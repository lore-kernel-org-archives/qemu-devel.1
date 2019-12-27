Return-Path: <SRS0=GTQb=2R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E8D9C2D0C3
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Dec 2019 19:08:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A15A2053B
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Dec 2019 19:08:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FSjr0BRV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A15A2053B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38078 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ikuyc-0000TC-Ay
	for qemu-devel@archiver.kernel.org; Fri, 27 Dec 2019 14:08:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36545)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1ikuxP-0008Uh-5f
 for qemu-devel@nongnu.org; Fri, 27 Dec 2019 14:07:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1ikuxM-0006Fa-HH
 for qemu-devel@nongnu.org; Fri, 27 Dec 2019 14:07:29 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:54111
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1ikuxM-00068l-2F
 for qemu-devel@nongnu.org; Fri, 27 Dec 2019 14:07:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1577473645;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SXjrlhamTtfyvg/D1SArliTdZ6lTrA0Xoo/qczgYVRo=;
 b=FSjr0BRV3d9kmeBFucz5jriSEHzwNElD9BD9d9RliGtEF2BG/IQhi+gEWxLr8ihqht2ANO
 TZ/A20PMh2HFQdXX5x2t5N4Uf2W0Wba8KkhgOTCROfaFmd+5/sgWwUK0ATgNoGfkxYyUKH
 zXVaPM8ZFNHKtDoqgJ1fNtf01v4a35I=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-436-057kCzTKO7KdykXUW1DS0Q-1; Fri, 27 Dec 2019 14:07:22 -0500
Received: by mail-wm1-f70.google.com with SMTP id q26so1096074wmq.8
 for <qemu-devel@nongnu.org>; Fri, 27 Dec 2019 11:07:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=X9cXhnEfXjeuZXUX2Qj0A4879k2VqnICTtn7FUljaNU=;
 b=ki7Ji6O4V2d1KGvC8Dg0ILB1UtQa6cvGaP5dK7+pi/Cz9FyplLGghzSJhEJfcgfQZK
 tu3KqbPT+wH3Tz17Vr1olnNhdgOLGmfSyf5rqZ/7xbe+o/CnOp7PL0asAD5hUNIuKSzr
 vkeJhutvzP+k1tKSOj+4P90YIJ6c5qNCW8zfTYzjXVe9KRSfL7eMUdc2p7M3eEVezOBt
 1YMQ+42dq6hEVul663vfA3C4byd0TzdLiK5lmOj284tFwomt0F8dMNu2m8FeR7p1X/tJ
 HGPBpYmVxq+sR7q10pBb5SeAJVBEkBcnPbSJAM38Jh7nvdReZqNHSMiZu3GYO2b3wrb9
 rwdw==
X-Gm-Message-State: APjAAAUXH4p/G1oexSk5XDHnDA0/HDOQz6H+umKdysXaOyZ2+Ee2bLez
 yxI4W+IzNWp1DYE9WsBlCNcpLzQY0dkP7Nsn8xz7WKbEygqeYwRBMQeLX+KOipK/FMLRvwK3KCK
 S4KRJiINGsnnxaNs=
X-Received: by 2002:a5d:6551:: with SMTP id z17mr54941580wrv.269.1577473640881; 
 Fri, 27 Dec 2019 11:07:20 -0800 (PST)
X-Google-Smtp-Source: APXvYqwOChvOldgwInKzO6Y2Zj7B2DqwzQgNZbpu4df/5LH9XJnLkATSSANvMvdzZE6hyL9rBehwXg==
X-Received: by 2002:a5d:6551:: with SMTP id z17mr54941569wrv.269.1577473640693; 
 Fri, 27 Dec 2019 11:07:20 -0800 (PST)
Received: from [192.168.1.25] (abayonne-654-1-186-92.w92-134.abo.wanadoo.fr.
 [92.134.161.92])
 by smtp.gmail.com with ESMTPSA id l15sm35493367wrv.39.2019.12.27.11.07.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 27 Dec 2019 11:07:19 -0800 (PST)
Subject: Re: [PATCH 3/5] python/qemu: qmp: Make accept()'s timeout configurable
To: Wainer dos Santos Moschetta <wainersm@redhat.com>, qemu-devel@nongnu.org
References: <20191227134101.244496-1-wainersm@redhat.com>
 <20191227134101.244496-4-wainersm@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <f27657e1-7ef8-e729-604c-29f01894eec3@redhat.com>
Date: Fri, 27 Dec 2019 20:07:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191227134101.244496-4-wainersm@redhat.com>
Content-Language: en-US
X-MC-Unique: 057kCzTKO7KdykXUW1DS0Q-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8; format=flowed
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
Cc: ehabkost@redhat.com, crosa@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/27/19 2:40 PM, Wainer dos Santos Moschetta wrote:
> Currently the timeout of QEMUMonitorProtocol.accept() is
> hard-coded to 15 seconds. This added the parameter `timeout`
> so the value can be configured by the user.
>=20
> Signed-off-by: Wainer dos Santos Moschetta <wainersm@redhat.com>
> ---
>   python/qemu/qmp.py | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
>=20
> diff --git a/python/qemu/qmp.py b/python/qemu/qmp.py
> index f4e04a6683..914b8c6774 100644
> --- a/python/qemu/qmp.py
> +++ b/python/qemu/qmp.py
> @@ -154,16 +154,17 @@ class QEMUMonitorProtocol:
>               return self.__negotiate_capabilities()
>           return None
>  =20
> -    def accept(self):
> +    def accept(self, timeout=3D15):
>           """
>           Await connection from QMP Monitor and perform capabilities nego=
tiation.
>  =20
> +        @param timeout (float): timeout in seconds. Default is 15.

Maybe name with unit: 'timeout_s'.

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

>           @return QMP greeting dict
>           @raise OSError on socket connection errors
>           @raise QMPConnectError if the greeting is not received
>           @raise QMPCapabilitiesError if fails to negotiate capabilities
>           """
> -        self.__sock.settimeout(15)
> +        self.__sock.settimeout(timeout)
>           self.__sock, _ =3D self.__sock.accept()
>           self.__sockfile =3D self.__sock.makefile()
>           return self.__negotiate_capabilities()
>=20


