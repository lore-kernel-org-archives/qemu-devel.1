Received: from eggs.gnu.org ([2001:4830:134:3::10]:55472)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent.desnogues@gmail.com>) id 1dPQNp-000364-DZ
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 05:32:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent.desnogues@gmail.com>) id 1dPQNo-0003CA-C6
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 05:32:37 -0400
Received: from mail-oi0-x22b.google.com ([2607:f8b0:4003:c06::22b]:33098)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent.desnogues@gmail.com>)
	id 1dPQNo-0003BU-5y
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 05:32:36 -0400
Received: by mail-oi0-x22b.google.com with SMTP id p66so51336275oia.0
	for <qemu-devel@nongnu.org>; Mon, 26 Jun 2017 02:32:34 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <87d19rf6p5.fsf@frigg.lan>
References: <1496975122-16999-1-git-send-email-cota@braap.org>
	<1496975122-16999-8-git-send-email-cota@braap.org>
	<20170626082844.GA4181@redhat.com> <87d19rf6p5.fsf@frigg.lan>
From: Laurent Desnogues <laurent.desnogues@gmail.com>
Date: Mon, 26 Jun 2017 11:32:33 +0200
Message-ID: <CABoDooMyuJ1b_-3uXvtr7exQ-UmQ+17QwqWiXf3BnvrOtz2mng@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v8 7/7] trace: [trivial] Statically enable
 all guest events
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, "Emilio G. Cota" <cota@braap.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, =?UTF-8?Q?Llu=C3=ADs_Vilanova?= <vilanova@ac.upc.edu>

On Mon, Jun 26, 2017 at 11:18 AM, Llu=C3=ADs Vilanova <vilanova@ac.upc.edu>=
 wrote:
> Daniel P Berrange writes:
>
>> On Thu, Jun 08, 2017 at 10:25:22PM -0400, Emilio G. Cota wrote:
>>> From: Llu=C3=ADs Vilanova <vilanova@ac.upc.edu>
>>>
>>> The optimizations of this series makes it feasible to have them
>>> available on all builds.
>
>> I'm not saying you're wrong, but where is the data to backup this
>> assertion ?
>
>> IMHO, this commit message should be describing how performance was
>> tested and what the results were.
>
> I can submit a new series with the performance measurements now that you'=
ve
> informally OK'ed Emilio's new patch.
>
> Is there some public script to automate that or do I have to cook my own?

Emilio proposed this for user mode:

https://github.com/cota/dbt-bench

IIRC he also has a Linux image that boots and shutdowns immediately.

Hope this helps,

Laurent
