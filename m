Return-Path: <SRS0=DspQ=T5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08180C28CC0
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2019 14:37:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 95F4823430
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2019 14:37:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95F4823430
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:55508 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hVzha-0006Dy-NY
	for qemu-devel@archiver.kernel.org; Wed, 29 May 2019 10:37:14 -0400
Received: from eggs.gnu.org ([209.51.188.92]:35062)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ppandit@redhat.com>) id 1hVzg8-00059g-0O
	for qemu-devel@nongnu.org; Wed, 29 May 2019 10:35:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ppandit@redhat.com>) id 1hVzg7-0000pe-6U
	for qemu-devel@nongnu.org; Wed, 29 May 2019 10:35:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46328)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ppandit@redhat.com>) id 1hVzg7-0000oc-0Y
	for qemu-devel@nongnu.org; Wed, 29 May 2019 10:35:43 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0D347307D983;
	Wed, 29 May 2019 14:35:42 +0000 (UTC)
Received: from kaapi (unknown [10.35.206.19])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 65FD46A24E;
	Wed, 29 May 2019 14:35:34 +0000 (UTC)
Date: Wed, 29 May 2019 20:05:28 +0530 (IST)
From: P J P <ppandit@redhat.com>
X-X-Sender: pjp@kaapi
To: =?ISO-8859-15?Q?Marc-Andr=E9_Lureau?= <marcandre.lureau@gmail.com>
In-Reply-To: <CAJ+F1C+xhBeoVqoE4aPgLqquq7rNKbZTtNSHe73FFgMyDCUzyw@mail.gmail.com>
Message-ID: <nycvar.YSQ.7.76.1905291932220.23737@xnncv>
References: <20190519084815.7410-1-ppandit@redhat.com>
	<CAJ+F1CLXdw4gE45vVEpStKrKsu-OYy1+5caC9wUduEtQRhjrpA@mail.gmail.com>
	<nycvar.YSQ.7.76.1905231257400.23354@xnncv>
	<CAJ+F1CLH1qN-jVVaMacMB41PWfZ5Xd9A8ycowaNxwgvQhPEvMQ@mail.gmail.com>
	<nycvar.YSQ.7.76.1905291448250.16122@xnncv>
	<CAJ+F1C+xhBeoVqoE4aPgLqquq7rNKbZTtNSHe73FFgMyDCUzyw@mail.gmail.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.48]);
	Wed, 29 May 2019 14:35:42 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Content-Type: text/plain; charset=UTF-8
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

+-- On Wed, 29 May 2019, Marc-Andr=C3=A9 Lureau wrote --+
| assert() is good if it's a programming error: that is if it should neve=
r=20
| happen at run-time. It's a decent way to document the code.

  True; But terminating server because a user sent more input parameters =
does=20
not sound good.

  {"error": {"class": "GenericError", "desc": "Guest agent command failed=
,=20
   error was 'Failed to execute child process \u201C/bin/ls\u201D
  (Argument list too long)'"}}

returning an error, as it does, is better IMO.

| >
| > I think same limit will apply to commands coming via QAPIs as well?
|
| What do you mean? If the generated API is used internally by QEMU?
| (it's not, but in this case there would be no limit)

IIUC, the QAPIs could be used by external libraries/clients to send=20
messages/commands to qemu/qemu-ga?

Thank you.
--
Prasad J Pandit / Red Hat Product Security Team
47AF CE69 3A90 54AA 9045 1053 DD13 3D32 FE5B 041F
