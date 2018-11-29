Received: from eggs.gnu.org ([2001:4830:134:3::10]:59575)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gSQV4-0003uP-1V
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 12:53:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gSQV0-0000sT-Mg
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 12:53:17 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53360)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gSQUz-0000rs-Ls
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 12:53:14 -0500
References: <1543442171-24863-1-git-send-email-linux@roeck-us.net>
	<1543442171-24863-2-git-send-email-linux@roeck-us.net>
	<3d1287e7-29c1-dbb1-c0f9-273b7b31645c@redhat.com>
	<734e8388-2f0f-1c5b-7767-29e43d261bcb@ilande.co.uk>
	<20181129173845.GA2929@roeck-us.net>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <1012f9d2-426d-d120-8ec5-2afe8eec4578@redhat.com>
Date: Thu, 29 Nov 2018 18:53:07 +0100
MIME-Version: 1.0
In-Reply-To: <20181129173845.GA2929@roeck-us.net>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/2] scsi: esp: Improve consistency of
 RSTAT, RSEQ, and RINTR
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Guenter Roeck <linux@roeck-us.net>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org

On 29/11/18 18:38, Guenter Roeck wrote:
> This looks much cleaner than the previous patch and at the same time
> identifies the problem. Enabling the new trace shows that the condition
> is seen on a regular basis (on average 2-3 times per boot test with
> qemu-system-hppa if the test does nothing but shut down immediately).

Yes, this looks very nice.  I'll queue it if Mark reports that it works,
with just s/_esp_command_complete/esp_report_command_complete/.

Paolo
