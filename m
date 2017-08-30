Received: from eggs.gnu.org ([2001:4830:134:3::10]:45946)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dmuVd-000808-Hx
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 00:21:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dmuVY-0005LR-KG
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 00:21:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46132)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dmuVY-0005LL-Db
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 00:21:40 -0400
Date: Wed, 30 Aug 2017 12:21:33 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170830042133.GG4208@lemon.lan>
References: <1504025019-16820-1-git-send-email-chugh.ishani@research.iiit.ac.in>
	<1504025019-16820-2-git-send-email-chugh.ishani@research.iiit.ac.in>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1504025019-16820-2-git-send-email-chugh.ishani@research.iiit.ac.in>
Subject: Re: [Qemu-devel] [PATCH v2 1/3] backup: QEMU Backup Tool
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ishani Chugh <chugh.ishani@research.iiit.ac.in>
Cc: qemu-devel@nongnu.org, jsnow@redhat.com, stefanha@redhat.com

On Tue, 08/29 22:13, Ishani Chugh wrote:
> +class BackupTool(object):
> +    """BackupTool Class"""
> +    def __init__(self, config_file=os.path.expanduser('~') +
> +                 '/.config/qemu/qemu-backup-config'):
> +        if "QEMU_BACKUP_CONFIG" in os.environ:
> +            self.config_file = os.environ["QEMU_BACKUP_CONFIG"]
> +        else:
> +            self.config_file = config_file
> +            try:
> +                if not os.path.isdir(os.path.dirname(self.config_file)):
> +                    os.makedirs(os.path.dirname(self.config_file))
> +            except:
> +                print("Cannot create config directory", file=sys.stderr)
> +                sys.exit(1)
> +        self.config = configparser.ConfigParser()
> +        self.config.read(self.config_file)

I suggest adding versioning to the config file, so that a future update to this
tool can make an incompatible change without breaking older tool:

[general]
version=0.1

[guest_1]
...

[guest_2]
...

And only continue if the version is known.

Fam
