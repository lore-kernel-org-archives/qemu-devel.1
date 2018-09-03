Received: from eggs.gnu.org ([2001:4830:134:3::10]:41115)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fwlDu-0005bS-I0
	for qemu-devel@nongnu.org; Mon, 03 Sep 2018 05:32:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fwlDq-0007Ke-9d
	for qemu-devel@nongnu.org; Mon, 03 Sep 2018 05:32:42 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:53208 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1fwlDq-0007KB-0r
	for qemu-devel@nongnu.org; Mon, 03 Sep 2018 05:32:38 -0400
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <1535778675-32170-2-git-send-email-wei@redhat.com> (Wei Huang's
	message of "Sat, 1 Sep 2018 01:11:12 -0400")
References: <1535778675-32170-1-git-send-email-wei@redhat.com>
	<1535778675-32170-2-git-send-email-wei@redhat.com>
Reply-To: quintela@redhat.com
Date: Mon, 03 Sep 2018 11:32:31 +0200
Message-ID: <877ek33p00.fsf@trasno.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH V8 1/4] tests/migration: Convert x86 boot
 block compilation script into Makefile
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Wei Huang <wei@redhat.com>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org, lvivier@redhat.com, drjones@redhat.com, dgilbert@redhat.com

Wei Huang <wei@redhat.com> wrote:
> The x86 boot block header currently is generated with a shell script.
> To better support other CPUs (e.g. aarch64), we convert the script
> into Makefile. This allows us to 1) support cross-compilation easily,
> and 2) avoid creating a script file for every architecture.
>
> Note that, in the new design, the cross compiler prefix can be specified by
> setting the CROSS_PREFIX in "make" command. Also to allow gcc pre-processor
> to include the C-style file correctly, it also renames the
> x86-a-b-bootblock.s file extension from .s to .S.
>
> Signed-off-by: Wei Huang <wei@redhat.com>

Reviewed-by: Juan Quintela <quintela@redhat.com>
