Received: from eggs.gnu.org ([2001:4830:134:3::10]:60449)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dUuOZ-00020N-Nn
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 08:36:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dUuOV-000297-Q7
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 08:36:03 -0400
Received: from roura.ac.upc.es ([147.83.33.10]:40437)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dUuOV-00028V-E5
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 08:35:59 -0400
From: =?utf-8?Q?Llu=C3=ADs_Vilanova?= <vilanova@ac.upc.edu>
References: <1498514681-3059-1-git-send-email-cota@braap.org>
	<20170710120744.GC14195@stefanha-x1.localdomain>
Date: Tue, 11 Jul 2017 15:35:44 +0300
In-Reply-To: <20170710120744.GC14195@stefanha-x1.localdomain> (Stefan
	Hajnoczi's message of "Mon, 10 Jul 2017 13:07:44 +0100")
Message-ID: <87a84bkv6n.fsf@frigg.lan>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v9 0/7] trace: Optimize per-vCPU TCG
 tracing states
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: "Emilio G. Cota" <cota@braap.org>, qemu-devel@nongnu.org, "Daniel P . Berrange" <berrange@redhat.com>, Richard Henderson <rth@twiddle.net>, Laurent Desnogues <laurent.desnogues@gmail.com>

Stefan Hajnoczi writes:

> On Mon, Jun 26, 2017 at 06:04:34PM -0400, Emilio G. Cota wrote:
>> v8: https://lists.gnu.org/archive/html/qemu-devel/2017-06/msg02335.html
>> 
>> Changes from v8:
>> 
>> - Rebased on top of the current tracing tree -- the one that includes
>> Lluis' fix (2c321e3c486).
>> - Added Lluis' R-b tag.
>> - Added perf numbers in the commit log of the last patch (tl;dr: no overhead).
>> 
>> Thanks,
>> 
>> Emilio
>> 
>> PS. How to quickly get some linux-user perf numbers:
>> 
>> I used dbt-bench[1] for a before/after comparison. I added a script to that
>> repo (breakdown.pl, see below) to make it play well with barchart[2].
>> Obtaining a comparison bar chart is quite simple:
>> 
>> 1. Generate one dbt-bench output file per QEMU checkout, e.g.:
>> $ git checkout orig && make
>> [ orig == "before"; new == "after" ]
>> $ ./dbt-bench.pl /path/to/qemu/build/qemu-x86_64 > orig.out
>> [ then do the same with orig-disabled, new, etc.]
>> [...]
>> $ ls *.out
>> new-disabled.out  new.out  orig-enabled.out  orig.out
>> 
>> 2. Call dbt-bench's breakdown.pl script with the --barchart option, then
>> pipe the output to barchart, and finally pipe to gnuplot:
>> $ ./breakdown.pl --barchart orig.out orig-enabled.out new.out new-disabled.out \
>> | ../barchart/barchart.pl --extra-gnuplot='set term dumb 140 30' \
>> --extra-gnuplot='set title "NBench score; higher is better"' \
>> | gnuplot
>> 
>> Note that barchart is just a front-end for gnuplot >=5, so any valid term will
>> work (e.g. 'set term pngcairo size 1200,500').
>> 
>> [1] https://github.com/cota/dbt-bench
>> [2] https://github.com/cota/barchart
>> 

> Thanks, applied to my tracing tree:
> https://github.com/stefanha/qemu/commits/tracing

Just to be sure, there's a v11 on the list (this is v9).


Cheers,
  Lluis
