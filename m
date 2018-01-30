Received: from eggs.gnu.org ([2001:4830:134:3::10]:39210)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1egVRf-00068M-5T
	for qemu-devel@nongnu.org; Tue, 30 Jan 2018 07:55:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1egVRa-0004Pi-3E
	for qemu-devel@nongnu.org; Tue, 30 Jan 2018 07:55:26 -0500
Received: from mx1.redhat.com ([209.132.183.28]:32794)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1egVRZ-0004Nl-OX
	for qemu-devel@nongnu.org; Tue, 30 Jan 2018 07:55:21 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 6622C2CE918
	for <qemu-devel@nongnu.org>; Tue, 30 Jan 2018 12:55:20 +0000 (UTC)
Date: Tue, 30 Jan 2018 13:55:14 +0100
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20180130135514.065e1c6a@redhat.com>
In-Reply-To: <1516116626-195863-1-git-send-email-imammedo@redhat.com>
References: <1516116626-195863-1-git-send-email-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2] tests: acpi: fix FADT not being
 compared to reference table
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com

On Tue, 16 Jan 2018 16:30:26 +0100
Igor Mammedov <imammedo@redhat.com> wrote:

> It turns out that FADT isn't actually tested for changes
> against reference table, since it happens to be the 1st
> table in RSDT which is currently ignored.
> Fix it by making sure that all tables from RSDT are added
> to test list.
> 
> NOTE: FADT contains guest allocated pointers to FACS/DSDT,
> zero them out so that possible FACS/DSDT address change
> won't affect test results.
> 
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> ---
> v2:
>   - fixup FACS/DSDT pointers in FADT to avoid false test
>     failure if pointers change ("Michael S. Tsirkin" <mst@redhat.com>)
ping

[...]
