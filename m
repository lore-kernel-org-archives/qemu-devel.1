Return-Path: <SRS0=bvyN=TX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20CE1C04AAC
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 07:55:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E13C620862
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 07:55:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E13C620862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:59488 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTiZV-0005GK-5o
	for qemu-devel@archiver.kernel.org; Thu, 23 May 2019 03:55:29 -0400
Received: from eggs.gnu.org ([209.51.188.92]:39815)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ppandit@redhat.com>) id 1hTiYK-0004bn-3c
	for qemu-devel@nongnu.org; Thu, 23 May 2019 03:54:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ppandit@redhat.com>) id 1hTiYJ-0000Y1-10
	for qemu-devel@nongnu.org; Thu, 23 May 2019 03:54:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33422)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ppandit@redhat.com>) id 1hTiYI-0000WD-SN
	for qemu-devel@nongnu.org; Thu, 23 May 2019 03:54:14 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 05B2C3D95D;
	Thu, 23 May 2019 07:54:13 +0000 (UTC)
Received: from kaapi (unknown [10.33.36.9])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 1D95267651;
	Thu, 23 May 2019 07:54:01 +0000 (UTC)
Date: Thu, 23 May 2019 13:23:36 +0530 (IST)
From: P J P <ppandit@redhat.com>
X-X-Sender: pjp@kaapi
To: =?ISO-8859-15?Q?Marc-Andr=E9_Lureau?= <marcandre.lureau@gmail.com>
In-Reply-To: <CAJ+F1CLXdw4gE45vVEpStKrKsu-OYy1+5caC9wUduEtQRhjrpA@mail.gmail.com>
Message-ID: <nycvar.YSQ.7.76.1905231257400.23354@xnncv>
References: <20190519084815.7410-1-ppandit@redhat.com>
	<CAJ+F1CLXdw4gE45vVEpStKrKsu-OYy1+5caC9wUduEtQRhjrpA@mail.gmail.com>
MIME-Version: 1.0
Content-ID: <nycvar.YSQ.7.76.1905231310040.23354@xnncv>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.30]);
	Thu, 23 May 2019 07:54:13 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Content-Type: text/plain; CHARSET=ISO-8859-15; FORMAT=flowed
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.21
Subject: Re: [Qemu-devel] [PATCH v2] qga: check length of command-line &
 environment variables
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: =?ISO-8859-15?Q?Ferm=EDn_J=2E_Serna?= <fjserna@gmail.com>,
	"Daniel P . Berrange" <berrange@redhat.com>,
	QEMU Developers <qemu-devel@nongnu.org>,
	Michael Roth <mdroth@linux.vnet.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

+-- On Wed, 22 May 2019, Marc-Andr=E9 Lureau wrote --+
| On Sun, May 19, 2019 at 10:55 AM P J P <ppandit@redhat.com> wrote:
| > Qemu guest agent while executing user commands does not seem to
| > check length of argument list and/or environment variables passed.
| > It may lead to integer overflow or infinite loop issues. Add check
| > to avoid it.
|=20
| Are you intentionally not telling where these overflow or loop happen?
|=20
| Isn't the kernel already giving an error if given too much
| environment/arguments on exec?

Kernel would report error; But integer overflow would occur while computi=
ng=20
'str_size' in a loop below, if count++ wraps around due to long list of=20
arguments (or a loop) in 'strList *entry'. Negative 'count' would allocat=
e=20
large memory for 'args'

    args =3D g_malloc(count * sizeof(char *));

We don't have a reproducer. It does seem remote/unlikely, considering=20
guest-agent is to be used by trusted parties to manage a guest.

| >      int count =3D 1, i =3D 0;  /* reserve for NULL terminator */
| > +    size_t str_size =3D 1, arg_max;
| >
| > +    arg_max =3D ga_get_arg_max();
| >      for (it =3D entry; it !=3D NULL; it =3D it->next) {
| >          count++;
| >          str_size +=3D 1 + strlen(it->value);
| > +        if (str_size >=3D arg_max || count >=3D arg_max / 2) {
| > +            break;
|=20
| This seems to silently drop remaining arguments, which is probably not
| what you want.

Umnm, report an error and return?


Thank you.
--
Prasad J Pandit / Red Hat Product Security Team
47AF CE69 3A90 54AA 9045 1053 DD13 3D32 FE5B 041F
