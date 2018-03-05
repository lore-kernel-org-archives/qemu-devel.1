Received: from eggs.gnu.org ([2001:4830:134:3::10]:45243)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1esvLR-000426-En
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 14:00:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1esvLO-0007Sx-6o
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 14:00:21 -0500
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:37157)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1esvLN-0007SK-Uk
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 14:00:18 -0500
Date: Mon, 5 Mar 2018 14:00:14 -0500
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20180305190014.GA17059@flamenco>
References: <1519690504-37792-1-git-send-email-mjc@sifive.com>
	<CAFEAcA_0qNcikG2iLii=4zEPYvhz1koEbhCCrCXssdKYv06OJA@mail.gmail.com>
	<CADJ6UvPQMDq_RES_u6WUmXHsita+On4oLu-V=emp3MnmmzjHhQ@mail.gmail.com>
	<CAHNT7Nv04hScm7QDtJMhFZeB=WOyOQ6HW1J-xOEO11GM1xFqyA@mail.gmail.com>
	<20180228222627.GA3575@flamenco>
	<CAHNT7NsPog=OLcU-RuVQQVpYk2n9nvHM453YLdDZocu8h0HYDQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHNT7NsPog=OLcU-RuVQQVpYk2n9nvHM453YLdDZocu8h0HYDQ@mail.gmail.com>
Subject: Re: [Qemu-devel] [patches] Re: [PULL] RISC-V QEMU Port Submission
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Clark <mjc@sifive.com>
Cc: Stef O'Rear <sorear2@gmail.com>, RISC-V Patches <patches@groups.riscv.org>, Palmer Dabbelt <palmer@sifive.com>, QEMU Developers <qemu-devel@nongnu.org>, Sagar Karandikar <sagark@eecs.berkeley.edu>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>

On Sat, Mar 03, 2018 at 02:26:12 +1300, Michael Clark wrote:
> It was qemu-2.7.50 (late 2016). The benchmarks were generated mid last year.
> 
> I can run the benchmarks again... Has it doubled in speed?

It depends on the benchmarks. Small-ish benchmarks such as rv8-bench
show about a 1.5x speedup since QEMU v2.6.0 for Aarch64:

                Aarch64 rv8-bench performance under QEMU user-mode              
                  Host: Intel(R) Core(TM) i7-6700K CPU @ 4.00GHz                
                                                                                
  4.5 +-+----+------+------+------+------+------+------+------+------+----+-+   
      |                                                 ++                  |   
    4 +-+..........v2.8.0.........v2.9.0........v2.10.0.%%.....v2.11.0....+-+   
  3.5 +-+...............................................%%@...............+-+   
      |                                                 %%@                 |   
    3 +-+...............................................%%@...............+-+   
  2.5 +-+...............................................%%@...............+-+   
      |                     ++                        $$$%@                 |   
    2 +-+.................$$$%@......................##.$%@...............+-+   
      |                  ##+$%@ ##$$%@               ## $%@                 |   
  1.5 +-+..+++%%@.......**#.$%@.##.$%@++++%%@........##.$%@........##$$%@.+-+   
    1 +-+.**#$$%@+##$$%@**#.$%@**#.$%@**#$$%@**#$$%@**#.$%@**#$$%@**#.$%@.+-+   
      |   **# $%@**# $%@**# $%@**# $%@**# $%@**#+$%@**# $%@**# $%@**# $%@   |   
  0.5 +-+-**#$$%@**#$$%@**#$$%@**#$$%@**#$$%@**#$$%@**#$$%@**#$$%@**#$$%@-+-+   
          aes bigidhrystone  miniz   norx primes  qsort sha512geomean           
  png: https://imgur.com/Agr5CJd

SPEC06int shows a larger improvement, up to ~2x avg speedup for the train
set:
          Aarch64 SPEC06int (train set) performance under QEMU user-mode        
                  Host: Intel(R) Core(TM) i7-6700K CPU @ 4.00GHz                
                                                                                
    4 +-+--+----+----+----+----+----+----+----+----+----+----+----+----+--+-+   
      |    %%                                           ++                  |   
  3.5 +-+..%%@.....v2.8.0.........v2.9.0........v2.10.0.%%+....v2.11.0....+-+   
      |    %%@                                          %%@       ++        |   
    3 +-+..%%@.......++.................................%%@.......%%+.....+-+   
      |   +$%@        |+                                %%@       %%@       |   
  2.5 +-+.##%@.......%%@...............................+$%@.......%%@.....+-+   
    2 +-+.##%@......+%%@.......%%@.................%%@.##%@.......%%@..++.+-+   
      |   ##%@  %%@ ##%@      +$%@       %%@       %%@ ##%@       $%@  %%@  |   
  1.5 +-+**#%@.##%@.##%@......##%@.......$%@.......$%@.##%@..%%+.##%@.##%@+-+   
      |  **#%@**#%@**#%@  +++**#%@      ##%@  ++  ##%@**#%@ ##%@ ##%@ ##%@  |   
    1 +-+**#%@**#%@**#%@**#%@**#%@**#%@**#%@**#%@+##%@**#%@+##%@**#%@**#%@+-+   
      |  **#%@**#%@**#%@**#%@**#%@**#%@**#%@**#%@**#%@**#%@**#%@**#%@**#%@  |   
  0.5 +-+**#%@**#%@**#%@**#%@**#%@**#%@**#%@**#%@**#%@**#%@**#%@**#%@**#%@+-+   
       401.bzi403.g429445.g456.h462.libq464.h471.omn4483.xalancbgeomean         
  png: https://imgur.com/JknVT5H

Note that the test set is less sensitive to the changes:
  https://imgur.com/W7CT0eO

Running small benchmarks (such as SPEC "test" or rv8-bench) is
very useful to get quick feedback on optimizations. However, some
of these runs are still dominated by parts of the code that aren't
that relevant -- for instance, some of them take so little time to
run that the major contributor to execution time is memory allocation.
Therefore, when publishing results it's best to stick with larger
benchmarks that run for longer (e.g. SPEC "train" set), which are more
sensitive to DBT performance.

I tried running some other benchmarks, such as nbench[1], under rv-jit.
I quickly get a "bus error" though -- don't know if I'm doing anything
wrong, or maybe compiling with the glibc cross-compiler I used
to build riscv linux isn't supported.
I managed though to run rv8-bench on both rv-jit and qemu (v8 patchset);
rv-jit is 1.30x faster on average for those, although note I dropped
qsort because it wasn't working properly on rv-jit:

               rv8-bench performance under rv-jit and QEMU user-mode            
                  Host: Intel(R) Core(TM) i7-6700K CPU @ 4.00GHz                
             [qsort does not finish cleanly for rv8, so I dropped it.]          
                                                                                
    3 +-+-----+-------+------+-------+-------+-------+------+-------+-----+-+   
  2.5 +-+..................*****..........................................+-+   
      |                    *-+-* b1bae23b7c2                                |   
    2 +-+..................*...*...................+-+-+..................+-+   
  1.5 +-+...........*****..*...*...................*****..................+-+   
      |     *****   *-+-*  *   *   *****           *   *   ++-+   *****     |   
    1 +-+...*-+-*...*...*..*...*...*...*...*****...*...*...****...*...*...+-+   
  0.5 +-+---*****---*****--*****---*****---*****---*****---****---*****---+-+   
           aes  bigidhrystone   miniz    norx  primes sha512 geomean            
  png: https://imgur.com/rLmTH3L

> I think I can get close to double again with tiered optimization and a good
> register allocator (lift RISC-V asm to SSA form). It's also a hotspot
> interpreter, which is definately faster than compiling all code, as I
> benchmarked it. It profiles and only translates hot paths, so code that
> only runs a few iterations is not translated. When I did eager transaltion
> I got a slow-down.

Yes, hotspot is great for real-life workloads (e.g. booting a system). Note
though that most benchmarks (e.g. SPEC) don't translate code that often;
most execution time is spent in loops and therefore the quality of
the generated code does matter. Hotspot detection of TBs/traces is great
for this as well, because it allows you to spend more resources generating
higher-quality code--for instance, see HQEMU[2].

Thanks,

		Emilio

[1] https://github.com/cota/nbench
[2] http://www.iis.sinica.edu.tw/papers/dyhong/18243-F.pdf
PS. One page with all the png's: https://imgur.com/a/5P5zj
