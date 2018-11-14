Received: from eggs.gnu.org ([2001:4830:134:3::10]:57638)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gMyet-0006ND-0P
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 12:08:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gMyeo-000619-SM
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 12:08:55 -0500
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:45089)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1gMyeo-0005yB-IG
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 12:08:50 -0500
Date: Wed, 14 Nov 2018 12:08:40 -0500
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20181114170840.GA960@flamenco>
References: <20181025172057.20414-1-cota@braap.org>
	<20181025172057.20414-2-cota@braap.org> <877ehfew1g.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <877ehfew1g.fsf@linaro.org>
Subject: Re: [Qemu-devel] [RFC 01/48] cpu: introduce run_on_cpu_no_bql
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>, =?iso-8859-1?Q?Llu=EDs?= Vilanova <vilanova@ac.upc.edu>, Peter Maydell <peter.maydell@linaro.org>, Stefan Hajnoczi <stefanha@gmail.com>

On Wed, Nov 14, 2018 at 11:30:19 +0000, Alex Bennée wrote:
> 
> Emilio G. Cota <cota@braap.org> writes:
> 
> > This allows us to queue synchronous CPU work without the BQL.
> >
> > Will gain a user soon.
> 
> This is also in the cpu-lock series right?

No, in the cpu-lock series we add async_run_on_cpu_no_bql;
here we add the sync version.

		E.
