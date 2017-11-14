Received: from eggs.gnu.org ([2001:4830:134:3::10]:51685)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1eEh94-0008I1-Sm
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 14:45:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1eEh94-0005pC-7S
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 14:45:18 -0500
References: <20171024230758.31779-1-riggle@google.com>
	<20171025033442.44872-1-zachriggle@gmail.com>
	<fac44468-7869-57fa-fb5f-fbd98828489f@vivier.eu>
	<CAMP9c5m6GK_Xwt6z3Bj+1WauHzHffzFb1cVD9ojeh2m8gA-D8w@mail.gmail.com>
	<CAMP9c5kG9m-swMJBtdQPzPkjLy7zq9sEdRA-PGcdeFDAT-DH9w@mail.gmail.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <b4ed3fcb-48a1-4304-9dab-1694e63eef3f@vivier.eu>
Date: Tue, 14 Nov 2017 20:44:58 +0100
MIME-Version: 1.0
In-Reply-To: <CAMP9c5kG9m-swMJBtdQPzPkjLy7zq9sEdRA-PGcdeFDAT-DH9w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2] linux-user: fix is_proc_myself to check
 the paths via realpath
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Zach Riggle <zachriggle@gmail.com>
Cc: QEMU Trivial <qemu-trivial@nongnu.org>, Riku Voipio <riku.voipio@iki.fi>, "open list:All patches CC here" <qemu-devel@nongnu.org>

Le 11/11/2017 à 02:48, Zach Riggle a écrit :
> I wrote up a quick example to show that this should work specifically for
> /proc/self/exe:
> 
> #define _GNU_SOURCE
> #include <sys/types.h>
> #include <sys/stat.h>
> #include <fcntl.h>
> #include <unistd.h>
> int main(int argc, char** argv) {
>     int fd = open("/proc/self/exe", O_NOFOLLOW | O_PATH);
>     system("ls -la /proc/$PPID/fd/");
> }
> 

And what about a readlink() in a loop until we cross "/proc/<pid>" (or not)?

Thanks,
Laurent
