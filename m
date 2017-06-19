Received: from eggs.gnu.org ([2001:4830:134:3::10]:54159)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dMo1I-0000RD-9v
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 00:10:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dMo1F-0000wf-5L
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 00:10:32 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:39039)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1dMo1F-0000wU-0C
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 00:10:29 -0400
Date: Mon, 19 Jun 2017 00:10:28 -0400
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20170619041028.GB10709@flamenco>
References: <149727922719.28532.11985025310576184920.stgit@frigg.lan>
	<149727924970.28532.9346819516051209538.stgit@frigg.lan>
	<20170615221911.GB26408@flamenco> <20170615232507.GA15332@flamenco>
	<87r2yhe5os.fsf@frigg.lan> <87a855b8n8.fsf@frigg.lan>
	<87y3sp9d36.fsf@frigg.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87y3sp9d36.fsf@frigg.lan>
Subject: Re: [Qemu-devel] [PATCH v6 3/6] target: [tcg] Add generic
 translation framework
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?Llu=EDs?= Vilanova <vilanova@ac.upc.edu>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>

On Mon, Jun 19, 2017 at 00:54:05 +0300, Lluís Vilanova wrote:
> Aha, just checked your proposed patches more closely and it totally makes sense
> to keep "is_jmp" to simplify the diffs, so I'll go for that one.

Also I think it's important to break down the changes to each
architecture into separate patches, otherwise the diff becomes
impossible to read. I went quite a long way with arm/translate.c
on Friday.

		E.
