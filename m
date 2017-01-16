Received: from eggs.gnu.org ([2001:4830:134:3::10]:60887)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1cTAoK-0002oT-Li
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 12:11:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1cTAoF-00045I-MW
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 12:11:12 -0500
Received: from roura.ac.upc.es ([147.83.33.10]:47902)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1cTAoF-000456-96
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 12:11:07 -0500
From: =?utf-8?Q?Llu=C3=ADs_Vilanova?= <vilanova@ac.upc.edu>
References: <148278447806.8988.12706825771606357198.stgit@fimbulvetr.bsc.es>
	<148278449426.8988.2219094135462471980.stgit@fimbulvetr.bsc.es>
	<20170109154439.GF30228@stefanha-x1.localdomain>
Date: Mon, 16 Jan 2017 18:10:57 +0100
In-Reply-To: <20170109154439.GF30228@stefanha-x1.localdomain> (Stefan
	Hajnoczi's message of "Mon, 9 Jan 2017 15:44:39 +0000")
Message-ID: <87o9z7c4m6.fsf@ac.upc.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 3/6] hypertrace: [*-user] Add QEMU-side
 proxy to "guest_hypertrace" event
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Daniel P Berrange <berrange@redhat.com>, Luiz Capitulino <lcapitulino@redhat.com>, Eric Blake <eblake@redhat.com>, Riku Voipio <riku.voipio@iki.fi>

Stefan Hajnoczi writes:

> On Mon, Dec 26, 2016 at 09:34:54PM +0100, Llu=C3=ADs Vilanova wrote:
[...]
>> +
>> +    } else {
>> +        /* proxy to next handler */
>> +        if (segv_next.sa_sigaction !=3D NULL) {
>> +            segv_next.sa_sigaction(signum, siginfo, sigctxt);
>> +        } else if (segv_next.sa_handler !=3D NULL) {
>> +            segv_next.sa_handler(signum);
>> +        }

> Is there a case when no signal handler was installed (i.e. default
> action)?

Sorry, in my previous email I meant no, there is none. If hypertrace is not
initialized, the segv handler will never be installed; otherwise segv_next =
will
always have one of the two values.


Thanks,
  Lluis
