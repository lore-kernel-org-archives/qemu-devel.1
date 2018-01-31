Received: from eggs.gnu.org ([2001:4830:134:3::10]:38526)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1egud7-0002rH-KS
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 10:48:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1egud5-0002gg-1z
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 10:48:57 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49072)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1egud4-0002gQ-SD
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 10:48:54 -0500
References: <20180131144846.31697-1-armbru@redhat.com>
	<20180131144846.31697-3-armbru@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <d5aec275-0c13-00fb-2116-10e3c5ed2b37@redhat.com>
Date: Wed, 31 Jan 2018 16:48:42 +0100
MIME-Version: 1.0
In-Reply-To: <20180131144846.31697-3-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 02/19] Clean up includes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: f4bug@amsat.org, Fam Zheng <famz@redhat.com>

On 31.01.2018 15:48, Markus Armbruster wrote:
> Clean up includes so that osdep.h is included first and headers
> which it implies are not included manually.
> 
> This commit was created with scripts/clean-includes, with the change
> to target/s390x/gen-features.c manually reverted, and blank lines
> around deletions collapsed.

Reviewed-by: Thomas Huth <thuth@redhat.com>

I wonder whether it would make sense to add a check based on
scripts/clean-includes to patchew already, so that these includes do not
sneak in so easily again...?

 Thomas
