Received: from eggs.gnu.org ([2001:4830:134:3::10]:52868)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <chugh.ishani@research.iiit.ac.in>)
	id 1dn4RW-0003Ay-51
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 10:58:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <chugh.ishani@research.iiit.ac.in>)
	id 1dn4RQ-0003To-3U
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 10:58:10 -0400
Received: from research.iiit.ac.in ([196.12.53.8]:39460)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <chugh.ishani@research.iiit.ac.in>)
	id 1dn4RP-0003So-Dx
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 10:58:04 -0400
Date: Wed, 30 Aug 2017 20:27:55 +0530 (IST)
From: Ishani <chugh.ishani@research.iiit.ac.in>
Message-ID: <1198198789.1361162.1504105075026.JavaMail.zimbra@research.iiit.ac.in>
In-Reply-To: <20170830042133.GG4208@lemon.lan>
References: <1504025019-16820-1-git-send-email-chugh.ishani@research.iiit.ac.in>
	<1504025019-16820-2-git-send-email-chugh.ishani@research.iiit.ac.in>
	<20170830042133.GG4208@lemon.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 1/3] backup: QEMU Backup Tool
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, jsnow <jsnow@redhat.com>, stefanha <stefanha@redhat.com>



----- On Aug 30, 2017, at 9:51 AM, Fam Zheng famz@redhat.com wrote:

> On Tue, 08/29 22:13, Ishani Chugh wrote:
>> +class BackupTool(object):
>> +    """BackupTool Class"""
>> +    def __init__(self, config_file=os.path.expanduser('~') +
>> +                 '/.config/qemu/qemu-backup-config'):
>> +        if "QEMU_BACKUP_CONFIG" in os.environ:
>> +            self.config_file = os.environ["QEMU_BACKUP_CONFIG"]
>> +        else:
>> +            self.config_file = config_file
>> +            try:
>> +                if not os.path.isdir(os.path.dirname(self.config_file)):
>> +                    os.makedirs(os.path.dirname(self.config_file))
>> +            except:
>> +                print("Cannot create config directory", file=sys.stderr)
>> +                sys.exit(1)
>> +        self.config = configparser.ConfigParser()
>> +        self.config.read(self.config_file)
> 
> I suggest adding versioning to the config file, so that a future update to this
> tool can make an incompatible change without breaking older tool:
> 
> [general]
> version=0.1
> 
> [guest_1]
> ...
> 
> [guest_2]
> ...
> 
> And only continue if the version is known.
> 
> Fam

I could not understand the intention behind adding versioning to config file.
Can you please elaborate a little on what is meant by incompatible change?

Regards,
Ishani
