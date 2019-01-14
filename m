Received: from eggs.gnu.org ([209.51.188.92]:50196)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gizT6-0001B0-RJ
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 05:27:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gizT5-0002qj-4y
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 05:27:43 -0500
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:41642)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gizT4-0002pN-VH
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 05:27:43 -0500
Received: by mail-ot1-x343.google.com with SMTP id u16so18842857otk.8
	for <qemu-devel@nongnu.org>; Mon, 14 Jan 2019 02:27:42 -0800 (PST)
MIME-Version: 1.0
References: <20190108163008.7006-1-peter.maydell@linaro.org>
	<20190108163008.7006-4-peter.maydell@linaro.org>
	<CAL1e-=gtbka64eAhVdbPyLa4+HP-OSQRg7u6+SC-8MCRgoZ9Qw@mail.gmail.com>
In-Reply-To: <CAL1e-=gtbka64eAhVdbPyLa4+HP-OSQRg7u6+SC-8MCRgoZ9Qw@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 14 Jan 2019 10:27:30 +0000
Message-ID: <CAFEAcA-FoPTcqZ5FH8Si6LUcYZgKVNPfHDBzd=x8QL4x+HDLVA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 3/4] accel/tcg: Add cluster number to TCG
 TB hash
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Cc: "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Eduardo Habkost <ehabkost@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Alistair Francis <alistair@alistair23.me>, Richard Henderson <richard.henderson@linaro.org>, "Emilio G . Cota" <cota@braap.org>, "patches@linaro.org" <patches@linaro.org>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>

On Mon, 14 Jan 2019 at 01:08, Aleksandar Markovic
<aleksandar.m.mail@gmail.com> wrote:
>
>
>
> On Tuesday, January 8, 2019, Peter Maydell <peter.maydell@linaro.org> wro=
te:
>>
>> Include the cluster number in the hash we use to look
>> up TBs. This is important because a TB that is valid
>> for one cluster at a given physical address and set
>> of CPU flags is not necessarily valid for another:
>> the two clusters may have different views of physical
>> memory, or may have different CPU features (eg FPU
>> present or absent).

> I do understand the definition of cluster_index in the sense of this seri=
es. However, it looks to me that the term "cluster" is generally overused i=
n areas where we work. This may lead to some confusion for future developer=
s, and let me suggest some other name, like "tcg_cluster_index" or "tcg_gro=
up_id", or "translation_group_id". Admitedly, they all sound ugly to me too=
. But having the name that would clearly separate this id from too generic =
"cluster_index" IMHO would save lots of time during potential related futur=
e development.
>
> (Needled to say that,  for example, we in MIPS, for multi-core sustems, g=
roup cores in clusters, that actually do not have anything to do with clust=
ers in TCG sense...)

Yeah, the term is a bit overloaded. Arm also has clusters
that are used more in the NUMA sense. However, the
term we have is what is in git master currently...

thanks
-- PMM
