Received: from eggs.gnu.org ([2001:4830:134:3::10]:46927)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fBtmw-0002FC-5u
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 23:11:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fBtmt-0006b0-0O
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 23:11:10 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:60622 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1fBtms-0006Ux-Rr
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 23:11:06 -0400
Date: Fri, 27 Apr 2018 11:10:54 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20180427031054.GL17690@lemon.usersys.redhat.com>
References: <20180426135755.GI29865@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180426135755.GI29865@localhost.localdomain>
Subject: Re: [Qemu-devel] Who is running QEMU automated tests, and when?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Yash Mankad <ymankad@redhat.com>, Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, Cleber Rosa <crosa@redhat.com>, Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>

On Thu, 04/26 10:57, Eduardo Habkost wrote:
> So, for anybody that runs automated QEMU tests once in a while,
> can we know:
> 
> * What test cases are you running?  Where can we get more
>   information about the tests you run?

These currently run on patchew:

 * checkpatch
 * ./configure && make (s390 host)
 * make docker-test-mingw@fedora
 * make docker-test-quick@centos6
 * make docker-test-build@min-glib


> * When do you run them?  What triggers a new test run?

They are run against each series posted to qemu-devel@nongnu.org. All errors are
sent as reply to the cover letter with the concrete commands, env info and log.

(Should we create a wiki page to maintain information collected by this thread?)

Fam
