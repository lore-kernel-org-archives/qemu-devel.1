Received: from eggs.gnu.org ([209.51.188.92]:39164)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <crobinso@redhat.com>) id 1hBMPj-0006Pe-8Y
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 12:37:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <crobinso@redhat.com>) id 1hBMIo-0003s1-7h
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 12:30:23 -0400
References: <20190401210011.16009-1-mdroth@linux.vnet.ibm.com>
From: Cole Robinson <crobinso@redhat.com>
Message-ID: <4d41daa4-743e-400b-d350-e89ca93b6c58@redhat.com>
Date: Tue, 2 Apr 2019 12:22:59 -0400
MIME-Version: 1.0
In-Reply-To: <20190401210011.16009-1-mdroth@linux.vnet.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-stable] [PATCH 00/97] Patch Round-up for
 stable 3.0.1, freeze on 2019-04-08
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org

On 4/1/19 4:58 PM, Michael Roth wrote:
> Hi everyone,                                                                                              
> 
> The following new patches are queued for QEMU stable v3.0.1:
> 
>   https://github.com/mdroth/qemu/commits/stable-3.0-staging
> 
> The release is planned for 2019-04-11:
> 
>   https://wiki.qemu.org/Planning/3.0
> 
> Please respond here or CC qemu-stable@nongnu.org on any patches you
> think should be included in the release.
> 
> Note that this update falls outside the normal stable release support
> window (~1 development cycle), but is being release now since it was
> delayed from its intended release date.
> 
> Thanks!
> 

Here's some extra patches we are carrying in Fedora 29

https://bugzilla.redhat.com/show_bug.cgi?id=CVE-2018-15746
6f2231e9b0 seccomp: use SIGSYS signal instead of killing the thread
bda08a5764 seccomp: prefer SCMP_ACT_KILL_PROCESS if available
d0699bd37c configure: require libseccomp 2.2.0
70dfabeaa7 seccomp: set the seccomp filter to all threads

https://bugzilla.redhat.com/show_bug.cgi?id=CVE-2018-18849
e58ccf0396 lsi53c895a: check message length value is valid

https://bugzilla.redhat.com/show_bug.cgi?id=CVE-2019-6778
a907458ad8 slirp: check data length while emulating ident function

https://bugzilla.redhat.com/show_bug.cgi?id=CVE-2018-18954
d07945e78e ppc/pnv: check size before data buffer access

https://bugzilla.redhat.com/show_bug.cgi?id=CVE-2018-19364
5b76ef50f6 9p: write lock path in v9fs_co_open2()
5b3c77aa58 9p: take write lock on fid path updates (CVE-2018-19364)

Thanks,
Cole
