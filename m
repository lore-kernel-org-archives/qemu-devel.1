Return-Path: <SRS0=xKZ8=TK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AB09C04A6B
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 15:59:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2175520881
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 15:59:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2175520881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:45612 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hP7vn-0001hE-FI
	for qemu-devel@archiver.kernel.org; Fri, 10 May 2019 11:59:31 -0400
Received: from eggs.gnu.org ([209.51.188.92]:36177)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1hP7t2-0007N7-H0
	for qemu-devel@nongnu.org; Fri, 10 May 2019 11:56:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1hP7t1-0005WN-Kn
	for qemu-devel@nongnu.org; Fri, 10 May 2019 11:56:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54298)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lvivier@redhat.com>) id 1hP7t1-0005VF-EG
	for qemu-devel@nongnu.org; Fri, 10 May 2019 11:56:39 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B47977E9C4;
	Fri, 10 May 2019 15:56:38 +0000 (UTC)
Received: from [10.40.205.9] (unknown [10.40.205.9])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 1335D66D22;
	Fri, 10 May 2019 15:56:30 +0000 (UTC)
To: =?UTF-8?Q?Daniel_P._Berrang=c3=a9?= <berrange@redhat.com>
References: <20190510102637.10209-1-lvivier@redhat.com>
	<87zhnuqyu0.fsf@dusky.pond.sub.org>
	<87991c2b-da9d-0e7f-bc09-9fbadbda4ef8@redhat.com>
	<20190510153227.GO7671@redhat.com>
From: Laurent Vivier <lvivier@redhat.com>
Message-ID: <a19fde61-159e-45da-f652-1dbc1f94b9ee@redhat.com>
Date: Fri, 10 May 2019 17:56:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
	Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20190510153227.GO7671@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.26]);
	Fri, 10 May 2019 15:56:38 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2] rng-builtin: add an RNG backend that
 uses qemu_guest_getrandom()
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
Cc: Kashyap Chamarthy <kchamart@redhat.com>,
	Markus Armbruster <armbru@redhat.com>, Amit Shah <amit@kernel.org>,
	Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
	"Richard W . M . Jones" <rjones@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/05/2019 17:32, Daniel P. Berrang=C3=A9 wrote:
> On Fri, May 10, 2019 at 02:37:41PM +0200, Laurent Vivier wrote:
>> On 10/05/2019 14:27, Markus Armbruster wrote:
>>> Laurent Vivier <lvivier@redhat.com> writes:
>>> The new rng-builtin is considerably simpler than both rng-random and
>>> rng-egd.  Moreover, it just works, whereas rng-random is limited to
>>> CONFIG_POSIX, and rng-egd needs egd running (which I suspect basicall=
y
>>> nobody does).  Have we considered deprecating these two backends in
>>> favor of rng-builtin?
>>
>> I have several bugzilla involving these backends: as there are blockin=
g, the
>> virtio-rng device in the guest can hang, or crash during hot-unplug. F=
rom my
>> point of view, life would be easier without them...
>=20
> Are you sure about that ?
>=20
> The EGD impl looks like it is requesting entropy in an async manner.

The virtio-rng driver waits until it receives enough entropy from the=20
RNG backend while a mutex is taken.

If the EGD daemon doesn't provide enough data to the RNG backend,=20
virtio-rng driver can hang.

It's easy to have if we start EGD backend with a socket in server,nowait=20
mode and no EGD daemon connects to the port.

Thanks,
Laurent


