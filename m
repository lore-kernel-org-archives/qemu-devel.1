Received: from eggs.gnu.org ([2001:4830:134:3::10]:36577)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1cPY15-0006Y5-OM
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 12:09:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1cPY12-0005ON-I9
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 12:09:23 -0500
Received: from roura.ac.upc.es ([147.83.33.10]:53032)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1cPY12-0005J2-5x
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 12:09:20 -0500
From: =?utf-8?Q?Llu=C3=ADs_Vilanova?= <vilanova@ac.upc.edu>
References: <20170106155543.12827-1-berrange@redhat.com>
	<20170106155543.12827-41-berrange@redhat.com>
Date: Fri, 06 Jan 2017 18:09:16 +0100
In-Reply-To: <20170106155543.12827-41-berrange@redhat.com> (Daniel
	P. Berrange's message of "Fri, 6 Jan 2017 15:55:36 +0000")
Message-ID: <87r34g2k03.fsf@ac.upc.edu>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v2 40/47] trace: switch target/s390x/
 directory to modular trace.h file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>

Daniel P Berrange writes:

> Switch files in the target/s390x/ directory to include the
> target/s390x/trace.h file instead of the global trace.h
> file.

> The make rules for gen-features.{h,c} need to be moved
> out into the top level Makefile.objs, otherwise make
> complains about the rules being defined multiple times
> due to target/s390x/Makefile.objs being included
> multiple times when expanding different subdir object
> lists.

If the problem is re-definition, you can instead add a guard around the rules in
target/s390x/Makefile.objs. This avoids defining the rules multiple times but
still keeps the target-specific rules in the target-specific makefile.


Cheers,
  Lluis
