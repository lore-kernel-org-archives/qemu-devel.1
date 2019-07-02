Return-Path: <SRS0=9yXi=U7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC597C06510
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 08:38:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C12C420659
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 08:38:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C12C420659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50668 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hiEIc-0006Jn-09
	for qemu-devel@archiver.kernel.org; Tue, 02 Jul 2019 04:38:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55634)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <slp@redhat.com>) id 1hiEHu-0005pd-Ko
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 04:37:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <slp@redhat.com>) id 1hiEHs-0002l1-Fv
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 04:37:18 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45648)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <slp@redhat.com>) id 1hiEHs-0002jk-7r
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 04:37:16 -0400
Received: by mail-wr1-f65.google.com with SMTP id f9so16695541wre.12
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2019 01:37:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version;
 bh=fk1MrtQwwcGe0jxWxj/tru5EAqS9V0IcpOSIlHkmhWQ=;
 b=pjzukZYrmfsiZ+S2IvWefg7NG8zBNJh9lHxt/OCVkkqmmHkdxsV4a55j3xzb7UANXj
 w1LxowkgBHy7WPxZs+Hw3bId99DWQBtBOVuomfAwEd5U9ZtEvGqT9Qo7Y/xP9gIHwCDf
 vqSq1dNn8B0Jk16GvN0933rTzW49E1ViH6lJNBMWgcVCE3RpXW27nRUMq8dWniqnZYYx
 r4zECVmlvhyFbpUiaepEJviJXAGVh41fMGS4vTxU0KnfnCthup3H4ZGpBLeV7aEOd5BA
 ANeDJpm2gzX6p2m3uhfpbkN0GJ/j+l6cObfO9g5ulsNI5vpv7wev2Sl0vJARtY5s4SMT
 pjuQ==
X-Gm-Message-State: APjAAAUDzNfienFkhM8BshMz4O2AS7HyMQFxV3fyCZjjgwXBCdSh0igQ
 hEiovKvUW6sjkOW1Mf0RP7le/HADLIBx5g==
X-Google-Smtp-Source: APXvYqxWQ4mWTCS+Vfc/U2SK2SNaNVoKjkCAgph879qdXQd1z0V1WO49vFxprh4oujSFVJ8xIOznog==
X-Received: by 2002:a5d:6b12:: with SMTP id v18mr2214070wrw.306.1562056634100; 
 Tue, 02 Jul 2019 01:37:14 -0700 (PDT)
Received: from dritchie.redhat.com (18.red-83-35-20.dynamicip.rima-tde.net.
 [83.35.20.18])
 by smtp.gmail.com with ESMTPSA id i188sm2501359wma.27.2019.07.02.01.37.12
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Tue, 02 Jul 2019 01:37:13 -0700 (PDT)
References: <20190701144705.102615-1-slp@redhat.com>
 <20190701144705.102615-3-slp@redhat.com>
 <20190702080200.2fzalvwmtcqgtpoq@sirius.home.kraxel.org>
User-agent: mu4e 1.2.0; emacs 26.2
From: Sergio Lopez <slp@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>
In-reply-to: <20190702080200.2fzalvwmtcqgtpoq@sirius.home.kraxel.org>
Date: Tue, 02 Jul 2019 10:37:11 +0200
Message-ID: <87a7dwygqw.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
 micalg=pgp-sha256; protocol="application/pgp-signature"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.65
Subject: Re: [Qemu-devel] [PATCH v2 2/4] hw/i386: Add an Intel MPTable
 generator
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
Cc: ehabkost@redhat.com, maran.wilson@oracle.com, mst@redhat.com,
 qemu-devel@nongnu.org, pbonzini@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Gerd Hoffmann <kraxel@redhat.com> writes:

> On Mon, Jul 01, 2019 at 04:47:03PM +0200, Sergio Lopez wrote:
>> Add a helper function (mptable_generate) for generating an Intel
>> MPTable according to version 1.4 of the specification.
>>=20
>> This is needed for the microvm machine type implementation.
>
> Firmware should do this IMHO (qboot or seabios).

Microvm does a number of things that are typically done by the firmware,
as a way to reduce boot time. I'm not opposed to support qboot, as long
it's optional. Otherwise microvm will break one of its three leitmotif.

Sergio.

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEvtX891EthoCRQuii9GknjS8MAjUFAl0bF7cACgkQ9GknjS8M
AjXkiw/+LmqUk8cEp4vn/tGj7f/oUReKo7N75W6l7b03nVvRzwFFAphQClIX+5xY
j4l49NsIJGwUkLZ4U/SIHwI+qJfqnamkryrn0akA0DjzBzQ+63GZgiRtqCYE0h/A
I6p7Ru9P8g2n5UctUKOTPjVoCFbLqDQVaOAu7EB+SRbeU1kLCyDXg0w2qMXwgU3h
OkQCclse57tXRMiOOxOFoouQ9GVlKWi4X5eyiF7VeknHzey01VgohRulJj/XamMB
6i8oLTAbCiL/wi8AJvtQ/AWAoBJxVl0Cp8JsfQ9IgDJ0KkQzpFEg5EhZO8tRBzud
0QK8OTZUNLHREaEoNlunFm6j1SRlO9tHA74n0Hvb9JIRoQiDS0C5461uDeV/I90e
RZq3ldhVnxNYCjtLazqetfKZHrTzRtWxcrdx1mO/tinWWOwL7psY1dCcpG2s9NIV
KbryqKdudcLktgDgWj0Ip7LGuWhxkI7Zn0OaZMkIrsdRTjvLQ8fEth9MMnKEnlOe
Hfw0mKarffXEXcePiMBIs/oMo6p6Fhufnb+xs2eymklcdSB3UgDSHqtgauDHVoAC
7h8Nj7t8boTAOFfuokvrt56fZS3INQp4T0mWPdC874+bZZfZs0w97ow0DfrDkjQ6
gVkSjXwRGDfzLtc6wHmbIBUJOZXLHJpkBYoTnfF9W5GhdPG+1KY=
=nVyU
-----END PGP SIGNATURE-----
--=-=-=--

