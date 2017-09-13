Received: from eggs.gnu.org ([2001:4830:134:3::10]:44366)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dsDti-0006Ab-Lw
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 16:04:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dsDtf-00033b-Hq
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 16:04:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39968)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jsnow@redhat.com>) id 1dsDtf-00033G-BV
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 16:04:31 -0400
References: <1504888905-22396-1-git-send-email-chugh.ishani@research.iiit.ac.in>
	<1504888905-22396-3-git-send-email-chugh.ishani@research.iiit.ac.in>
	<20170911050200.GB32341@lemon.lan>
From: John Snow <jsnow@redhat.com>
Message-ID: <4da9f6d9-ef16-cbc6-a1b9-1bf6f3465a6e@redhat.com>
Date: Wed, 13 Sep 2017 16:04:23 -0400
MIME-Version: 1.0
In-Reply-To: <20170911050200.GB32341@lemon.lan>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 2/3] backup: Adds Backup Tool
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>, Ishani Chugh <chugh.ishani@research.iiit.ac.in>
Cc: qemu-devel@nongnu.org, stefanha@redhat.com



On 09/11/2017 01:02 AM, Fam Zheng wrote:
> On Fri, 09/08 22:11, Ishani Chugh wrote:
>> +def build_parser():
>> +    backup_tool = BackupTool()
>> +    parser = ArgumentParser()
>> +    subparsers = parser.add_subparsers(title='Subcommands',
>> +                                       description='Valid Subcommands',
>> +                                       help='Subcommand help')
>> +    guest_parser = subparsers.add_parser('guest', help='Manage guest(s)')
>> +    guest_subparsers = guest_parser.add_subparsers(title='Guest Subparser')
>> +#   Guest list
> 
> Odd indentation of comments. Please align the # at 4th colume line other code
> lines.  The same to below.
> 

Sorry, that's probably my fault based on how I suggested the comments in
the previous email review. (:

Fam is right though, the pythonic way to comment is by aligning the
octothorpe to column 4 instead of leaving it at column 0.

--js
