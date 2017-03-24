Received: from eggs.gnu.org ([2001:4830:134:3::10]:42441)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1crQlI-0005F9-7S
	for Qemu-devel@nongnu.org; Fri, 24 Mar 2017 11:04:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1crQlC-0006Zp-N5
	for Qemu-devel@nongnu.org; Fri, 24 Mar 2017 11:04:20 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:59896
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1crQlC-0006XC-Hi
	for Qemu-devel@nongnu.org; Fri, 24 Mar 2017 11:04:14 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v2OF01N3099035
	for <Qemu-devel@nongnu.org>; Fri, 24 Mar 2017 11:04:11 -0400
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	by mx0b-001b2d01.pphosted.com with ESMTP id 29cg2rw39n-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <Qemu-devel@nongnu.org>; Fri, 24 Mar 2017 11:04:09 -0400
Received: from localhost
	by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <Qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Fri, 24 Mar 2017 09:04:07 -0600
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
From: Michael Roth <mdroth@linux.vnet.ibm.com>
In-Reply-To: <CAOvx4-1MYO14+hkP8ZZg6Y4v_GFU8HtzYSeRo692zbsZN8D79A@mail.gmail.com>
References: <CAOvx4-1MYO14+hkP8ZZg6Y4v_GFU8HtzYSeRo692zbsZN8D79A@mail.gmail.com>
Date: Fri, 24 Mar 2017 10:03:55 -0500
Message-Id: <149036783558.3910.1779320846654726604@loki>
Subject: Re: [Qemu-devel] guest-exec of qemu-guest-agent fails on Windows
 guest
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Armin Ranjbar <zoup@zoup.org>, Qemu-devel@nongnu.org
Cc: Behrooz <everplays@gmail.com>

What steps did you use to install qga? Did you use the .msi
installer? If not you'll need to make those glib helper executables
available to the agent by placing them in the install directory or
somewhere in its executable paths. The MSI installer should handle
all this for you.
