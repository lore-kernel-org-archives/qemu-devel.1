Received: from eggs.gnu.org ([2001:4830:134:3::10]:35698)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ppandit@redhat.com>) id 1gPlxm-0001it-BA
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 05:12:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ppandit@redhat.com>) id 1gPlxc-0004y7-3I
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 05:11:58 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43988)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ppandit@redhat.com>) id 1gPlxb-0004w5-S9
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 05:11:48 -0500
Date: Thu, 22 Nov 2018 15:41:38 +0530 (IST)
From: P J P <ppandit@redhat.com>
In-Reply-To: <00888856-0af3-7b1a-4622-3edbac9fe77f@linux.ibm.com>
Message-ID: <nycvar.YSQ.7.76.1811221532140.25476@xnncv>
References: <20181120072239.512-1-ppandit@redhat.com>
	<ea6eb292-53d6-9bf0-98b9-8b53c44e77c8@linux.ibm.com>
	<nycvar.YSQ.7.76.1811202318190.17923@xnncv>
	<00888856-0af3-7b1a-4622-3edbac9fe77f@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [Qemu-devel] [PATCH v1] tpm: check localities index
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Berger <stefanb@linux.ibm.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, =?ISO-8859-15?Q?Marc-Andr=E9_Lureau?= <marcandre.lureau@gmail.com>, Stefan Berger <stefanb@linux.vnet.ibm.com>, Cheng Feng <PSIRT@huawei.com>

+-- On Wed, 21 Nov 2018, Stefan Berger wrote --+
| I audited all functions yesterday and my proposed patches are on the mailing
| list. The abort related ones seem most critical but they are all passed values
| they can handle. I do not think that an out-of-bounds access can occur with
| the current code.
|
| I concur with Marc's comments that an 'assert(TPM_TIS_IS_VALID_LOCTY(locty));'
| on a preceding ' uint8_t locty = tpm_tis_locality_from_addr(addr);' isn't
| necessary unless something in the core code is seriously broken. tpm_tis
| covers address offsets of [0x0 .. 0x4fff] from its base address , which maps
| to localities 0..4

I see, okay; Thank you for the details. I think I need to experiment with it 
little more.

Thank you.
--
Prasad J Pandit / Red Hat Product Security Team
47AF CE69 3A90 54AA 9045 1053 DD13 3D32 FE5B 041F
