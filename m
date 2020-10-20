Return-Path: <SRS0=1sPN=D3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46640C4363A
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 19:31:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2671322251
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 19:31:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2671322251
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=joshdubois.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43104 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUxLf-00057W-08
	for qemu-devel@archiver.kernel.org; Tue, 20 Oct 2020 15:31:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41298)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <josh@joshdubois.com>)
 id 1kUxKe-0004Zi-05
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 15:30:04 -0400
Received: from jax4mhob11.myregisteredsite.com ([64.69.218.91]:34028
 helo=jax4mhob11.registeredsite.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <josh@joshdubois.com>)
 id 1kUxKb-0008WN-Of
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 15:30:03 -0400
Received: from mailpod.hostingplatform.com ([10.30.71.114])
 by jax4mhob11.registeredsite.com (8.14.4/8.14.4) with ESMTP id 09KJTwZS016293
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2020 15:29:58 -0400
Received: (qmail 46928 invoked by uid 0); 20 Oct 2020 19:29:57 -0000
X-TCPREMOTEIP: 50.93.248.134
X-Authenticated-UID: josh@joshdubois.com
Received: from unknown (HELO ?192.168.1.5?) (josh@joshdubois.com@50.93.248.134)
 by 0 with ESMTPA; 20 Oct 2020 19:29:57 -0000
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [PATCH] trace/simple: Enable tracing on startup only if the user
 specifies a trace option
From: Josh DuBois <josh@joshdubois.com>
In-Reply-To: <87blgxfe4n.fsf@dusky.pond.sub.org>
Date: Tue, 20 Oct 2020 14:29:56 -0500
Content-Transfer-Encoding: quoted-printable
Message-Id: <B1123C1E-0FFD-4DC4-9DA3-92B6FB4A4FA8@joshdubois.com>
References: <20200816174610.20253-1-josh@joshdubois.com>
 <20200911100805.GB81586@stefanha-x1.localdomain>
 <87lfgt3u0i.fsf@dusky.pond.sub.org> <87blgxfe4n.fsf@dusky.pond.sub.org>
To: Markus Armbruster <armbru@redhat.com>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Received-SPF: neutral client-ip=64.69.218.91; envelope-from=josh@joshdubois.com;
 helo=jax4mhob11.registeredsite.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/20 15:29:59
X-ACL-Warn: Detected OS   = Linux 3.1-3.10 [fuzzy]
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_NEUTRAL=0.779 autolearn=no autolearn_force=no
X-Spam_action: no action
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
Cc: qemu-trivial@nongnu.org, Stefan Hajnoczi <stefanha@gmail.com>,
 Josh DuBois <duboisj@gmail.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Thanks for keeping on following-up, Markus. =20

I know it's a small one, but it's still nice to have a small patch feel =
loved ;)

> On Oct 20, 2020, at 4:19 AM, Markus Armbruster <armbru@redhat.com> =
wrote:
>=20
> Markus Armbruster <armbru@redhat.com> writes:
>=20
>> Stefan Hajnoczi <stefanha@gmail.com> writes:
>>=20
>>> On Sun, Aug 16, 2020 at 12:46:10PM -0500, duboisj@gmail.com wrote:
>>>> From: Josh DuBois <josh@joshdubois.com>
>>>>=20
>>>> Tracing can be enabled at the command line or via the
>>>> monitor. Command-line trace options are recorded during
>>>> trace_opt_parse(), but tracing is not enabled until the various
>>>> front-ends later call trace_init_file(). If the user passes a trace
>>>> option on the command-line, remember that and enable tracing during
>>>> trace_init_file().  Otherwise, trace_init_file() should record the
>>>> trace file specified by the frontend and avoid enabling traces
>>>> until the user requests them via the monitor.
>>>>=20
>>>> This fixes 1b7157be3a8c4300fc8044d40f4b2e64a152a1b4 and also
>>>> db25d56c014aa1a96319c663e0a60346a223b31e, by allowing the user
>>>> to enable traces on the command line and also avoiding
>>>> unwanted trace-<pid> files when the user has not asked for them.
>>>>=20
>>>> Fixes: 1b7157be3a8c4300fc8044d40f4b2e64a152a1b4
>>>> Signed-off-by: Josh DuBois <josh@joshdubois.com>
>>>> ---
>>>> trace/control.c | 6 +++++-
>>>> 1 file changed, 5 insertions(+), 1 deletion(-)
>>>=20
>>> Thanks, applied to my tracing-next tree:
>>> https://github.com/stefanha/qemu/commits/tracing-next
>>>=20
>>> Stefan
>>=20
>> Pull request?
>=20
> Pretty-please?
>=20


