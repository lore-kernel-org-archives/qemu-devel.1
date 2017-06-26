Received: from eggs.gnu.org ([2001:4830:134:3::10]:33540)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dPb18-0005FE-Pn
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 16:53:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dPb17-00086v-UD
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 16:53:54 -0400
References: <CAJSP0QUD58kjc=8WAxwocK_HGJGqG-YeR5LqU3cCZCgdemZe4g@mail.gmail.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <71215f3b-4b44-accc-d84a-87d4749bf391@redhat.com>
Date: Mon, 26 Jun 2017 16:53:45 -0400
MIME-Version: 1.0
In-Reply-To: <CAJSP0QUD58kjc=8WAxwocK_HGJGqG-YeR5LqU3cCZCgdemZe4g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-block] Fuzzing event loops
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>, qemu-devel <qemu-devel@nongnu.org>
Cc: qemu block <qemu-block@nongnu.org>



On 06/11/2017 06:47 AM, Stefan Hajnoczi wrote:
> I wanted to share this idea about fuzzing event loops:
> 
> https://blog.acolyer.org/2017/06/09/node-fz-fuzzing-the-server-side-event-driven-architecture/
> 
> The idea is to expose ordering dependencies and atomicity bugs in
> event loop callbacks/coroutines by randomly shuffling the order in
> which fd handlers, timers, etc execute.
> 
> I'm not sure we'd find many bugs since QEMU tends to use big locks or
> request serialization when concurrency gets tricky in the block layer.
> Still, it's an interesting concept that we could apply in the future.
> 
> Stefan
> 

Sounds fun, probably too detailed for a GSoC/Outreachy project, right?
Do we have a page on the wiki for random "Hey, this might be nice..." ideas?

(Or is that a bad idea itself so we don't have a graveyard of 'not my
problem' projects?)

--js
