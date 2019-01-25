Received: from eggs.gnu.org ([209.51.188.92]:52196)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gn22A-0003c6-6q
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 09:00:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gn224-0000jx-LE
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 09:00:37 -0500
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434]:38239)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gn224-0000h5-48
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 09:00:32 -0500
Received: by mail-wr1-x434.google.com with SMTP id v13so10395853wrw.5
	for <qemu-devel@nongnu.org>; Fri, 25 Jan 2019 06:00:31 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Fri, 25 Jan 2019 14:00:12 +0000
Message-Id: <20190125140017.6092-10-alex.bennee@linaro.org>
In-Reply-To: <20190125140017.6092-1-alex.bennee@linaro.org>
References: <20190125140017.6092-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH  v1 09/14] tests: PEP8 cleanup of docker.py,
 mostly white space
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Fam Zheng <fam@euphon.net>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>

My editor keeps putting squiggly lines under a bunch of the python
lines to remind me how non-PEP8 compliant it is. Clean that up so it's
easier to spot new errors.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/docker/docker.py | 48 ++++++++++++++++++++++++++++++------------
 1 file changed, 35 insertions(+), 13 deletions(-)

diff --git a/tests/docker/docker.py b/tests/docker/docker.py
index a74338cb61..53a8c9c801 100755
--- a/tests/docker/docker.py
+++ b/tests/docker/docker.py
@@ -30,7 +30,7 @@ except ImportError:
     from io import StringIO
 from shutil import copy, rmtree
 from pwd import getpwuid
-from datetime import datetime,timedelta
+from datetime import datetime, timedelta
 
 
 FILTERED_ENV_NAMES = ['ftp_proxy', 'http_proxy', 'https_proxy']
@@ -43,9 +43,11 @@ def _text_checksum(text):
     """Calculate a digest string unique to the text content"""
     return hashlib.sha1(text).hexdigest()
 
+
 def _file_checksum(filename):
     return _text_checksum(open(filename, 'rb').read())
 
+
 def _guess_docker_command():
     """ Guess a working docker command or raise exception if not found"""
     commands = [["docker"], ["sudo", "-n", "docker"]]
@@ -59,9 +61,10 @@ def _guess_docker_command():
         except OSError:
             pass
     commands_txt = "\n".join(["  " + " ".join(x) for x in commands])
-    raise Exception("Cannot find working docker command. Tried:\n%s" % \
+    raise Exception("Cannot find working docker command. Tried:\n%s" %
                     commands_txt)
 
+
 def _copy_with_mkdir(src, root_dir, sub_path='.'):
     """Copy src into root_dir, creating sub_path as needed."""
     dest_dir = os.path.normpath("%s/%s" % (root_dir, sub_path))
@@ -96,6 +99,7 @@ def _get_so_libs(executable):
 
     return libs
 
+
 def _copy_binary_with_libs(src, bin_dest, dest_dir):
     """Maybe copy a binary and all its dependent libraries.
 
@@ -117,7 +121,7 @@ def _copy_binary_with_libs(src, bin_dest, dest_dir):
     if libs:
         for l in libs:
             so_path = os.path.dirname(l)
-            _copy_with_mkdir(l , dest_dir, so_path)
+            _copy_with_mkdir(l, dest_dir, so_path)
 
 
 def _check_binfmt_misc(executable):
@@ -142,7 +146,7 @@ def _check_binfmt_misc(executable):
     with open(binfmt_entry) as x: entry = x.read()
 
     if re.search("flags:.*F.*\n", entry):
-        print("binfmt_misc for %s uses persistent(F) mapping to host binary\n" %
+        print("binfmt_misc for %s uses persistent(F) mapping to host binary" %
               (binary))
         return None, True
 
@@ -164,6 +168,7 @@ def _read_qemu_dockerfile(img_name):
                       img_name + ".docker")
     return open(df, "r").read()
 
+
 def _dockerfile_preprocess(df):
     out = ""
     for l in df.splitlines():
@@ -181,6 +186,7 @@ def _dockerfile_preprocess(df):
         out += l + "\n"
     return out
 
+
 class Docker(object):
     """ Running Docker commands """
     def __init__(self):
@@ -248,7 +254,7 @@ class Docker(object):
 
     def build_image(self, tag, docker_dir, dockerfile,
                     quiet=True, user=False, argv=None, extra_files_cksum=[]):
-        if argv == None:
+        if argv is None:
             argv = []
 
         tmp_df = tempfile.NamedTemporaryFile(dir=docker_dir, suffix=".docker")
@@ -269,7 +275,7 @@ class Docker(object):
 
         tmp_df.flush()
 
-        self._do_check(["build", "-t", tag, "-f", tmp_df.name] + argv + \
+        self._do_check(["build", "-t", tag, "-f", tmp_df.name] + argv +
                        [docker_dir],
                        quiet=quiet)
 
@@ -299,9 +305,11 @@ class Docker(object):
     def command(self, cmd, argv, quiet):
         return self._do([cmd] + argv, quiet=quiet)
 
+
 class SubCommand(object):
     """A SubCommand template base class"""
-    name = None # Subcommand name
+    name = None  # Subcommand name
+
     def shared_args(self, parser):
         parser.add_argument("--quiet", action="store_true",
                             help="Run quietly unless an error occurred")
@@ -309,6 +317,7 @@ class SubCommand(object):
     def args(self, parser):
         """Setup argument parser"""
         pass
+
     def run(self, args, argv):
         """Run command.
         args: parsed argument by argument parser.
@@ -316,18 +325,23 @@ class SubCommand(object):
         """
         pass
 
+
 class RunCommand(SubCommand):
     """Invoke docker run and take care of cleaning up"""
     name = "run"
+
     def args(self, parser):
         parser.add_argument("--keep", action="store_true",
                             help="Don't remove image when command completes")
+
     def run(self, args, argv):
         return Docker().run(argv, args.keep, quiet=args.quiet)
 
+
 class BuildCommand(SubCommand):
-    """ Build docker image out of a dockerfile. Arguments: <tag> <dockerfile>"""
+    """ Build docker image out of a dockerfile. Arg: <tag> <dockerfile>"""
     name = "build"
+
     def args(self, parser):
         parser.add_argument("--include-executable", "-e",
                             help="""Specify a binary that will be copied to the
@@ -392,8 +406,8 @@ class BuildCommand(SubCommand):
                 cksum += [(filename, _file_checksum(filename))]
 
             argv += ["--build-arg=" + k.lower() + "=" + v
-                        for k, v in os.environ.iteritems()
-                        if k.lower() in FILTERED_ENV_NAMES]
+                     for k, v in os.environ.iteritems()
+                     if k.lower() in FILTERED_ENV_NAMES]
             dkr.build_image(tag, docker_dir, dockerfile,
                             quiet=args.quiet, user=args.user, argv=argv,
                             extra_files_cksum=cksum)
@@ -402,9 +416,11 @@ class BuildCommand(SubCommand):
 
         return 0
 
+
 class UpdateCommand(SubCommand):
-    """ Update a docker image with new executables. Arguments: <tag> <executable>"""
+    """ Update a docker image with new executables. Args: <tag> <executable>"""
     name = "update"
+
     def args(self, parser):
         parser.add_argument("tag",
                             help="Image Tag")
@@ -457,16 +473,20 @@ class UpdateCommand(SubCommand):
 
         return 0
 
+
 class CleanCommand(SubCommand):
     """Clean up docker instances"""
     name = "clean"
+
     def run(self, args, argv):
         Docker().clean()
         return 0
 
+
 class ImagesCommand(SubCommand):
     """Run "docker images" command"""
     name = "images"
+
     def run(self, args, argv):
         return Docker().command("images", argv, args.quiet)
 
@@ -539,7 +559,7 @@ class CheckCommand(SubCommand):
 
         try:
             dkr = Docker()
-        except:
+        except subprocess.CalledProcessError:
             print("Docker not set up")
             return 1
 
@@ -578,7 +598,8 @@ class CheckCommand(SubCommand):
 
 def main():
     parser = argparse.ArgumentParser(description="A Docker helper",
-            usage="%s <subcommand> ..." % os.path.basename(sys.argv[0]))
+                                     usage="%s <subcommand> ..." %
+                                     os.path.basename(sys.argv[0]))
     subparsers = parser.add_subparsers(title="subcommands", help=None)
     for cls in SubCommand.__subclasses__():
         cmd = cls()
@@ -589,5 +610,6 @@ def main():
     args, argv = parser.parse_known_args()
     return args.cmdobj.run(args, argv)
 
+
 if __name__ == "__main__":
     sys.exit(main())
-- 
2.17.1
