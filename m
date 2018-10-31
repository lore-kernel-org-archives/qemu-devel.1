Received: from eggs.gnu.org ([2001:4830:134:3::10]:43344)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gHeQw-0002cE-EK
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 20:32:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gHeQu-0004QI-8Z
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 20:32:30 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Tue, 30 Oct 2018 21:31:20 -0300
Message-Id: <20181031003120.26771-16-ehabkost@redhat.com>
In-Reply-To: <20181031003120.26771-1-ehabkost@redhat.com>
References: <20181031003120.26771-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PULL 15/15] scripts/qemu.py: use a more consistent
 docstring style
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org, Fam Zheng <famz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Cleber Rosa <crosa@redhat.com>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

From: Cleber Rosa <crosa@redhat.com>

Signed-off-by: Cleber Rosa <crosa@redhat.com>
Message-Id: <20181004161852.11673-10-crosa@redhat.com>
[ehabkost: reverted unintentional submodule update]
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 scripts/qemu.py | 65 +++++++++++++++++++++++++++++++------------------
 1 file changed, 41 insertions(+), 24 deletions(-)

diff --git a/scripts/qemu.py b/scripts/qemu.py
index 768611f1de..6e3b0e6771 100644
--- a/scripts/qemu.py
+++ b/scripts/qemu.py
@@ -59,9 +59,9 @@ class QEMUMachineAddDeviceError(QEMUMachineError):
     """
 
 class MonitorResponseError(qmp.qmp.QMPError):
-    '''
+    """
     Represents erroneous QMP monitor reply
-    '''
+    """
     def __init__(self, reply):
         try:
             desc = reply["error"]["desc"]
@@ -72,14 +72,15 @@ class MonitorResponseError(qmp.qmp.QMPError):
 
 
 class QEMUMachine(object):
-    '''A QEMU VM
+    """
+    A QEMU VM
 
     Use this object as a context manager to ensure the QEMU process terminates::
 
         with VM(binary) as vm:
             ...
         # vm is guaranteed to be shut down here
-    '''
+    """
 
     def __init__(self, binary, args=None, wrapper=None, name=None,
                  test_dir="/var/tmp", monitor_address=None,
@@ -141,7 +142,9 @@ class QEMUMachine(object):
         self._args.append(args)
 
     def add_fd(self, fd, fdset, opaque, opts=''):
-        '''Pass a file descriptor to the VM'''
+        """
+        Pass a file descriptor to the VM
+        """
         options = ['fd=%d' % fd,
                    'set=%d' % fdset,
                    'opaque=%s' % opaque]
@@ -197,7 +200,9 @@ class QEMUMachine(object):
 
     @staticmethod
     def _remove_if_exists(path):
-        '''Remove file object at path if it exists'''
+        """
+        Remove file object at path if it exists
+        """
         try:
             os.remove(path)
         except OSError as exception:
@@ -300,7 +305,9 @@ class QEMUMachine(object):
             raise
 
     def _launch(self):
-        '''Launch the VM and establish a QMP connection'''
+        """
+        Launch the VM and establish a QMP connection
+        """
         devnull = open(os.path.devnull, 'rb')
         self._pre_launch()
         self._qemu_full_args = (self._wrapper + [self._binary] +
@@ -314,14 +321,18 @@ class QEMUMachine(object):
         self._post_launch()
 
     def wait(self):
-        '''Wait for the VM to power off'''
+        """
+        Wait for the VM to power off
+        """
         self._popen.wait()
         self._qmp.close()
         self._load_io_log()
         self._post_shutdown()
 
     def shutdown(self):
-        '''Terminate the VM and clean up'''
+        """
+        Terminate the VM and clean up
+        """
         if self.is_running():
             try:
                 self._qmp.cmd('quit')
@@ -345,7 +356,9 @@ class QEMUMachine(object):
         self._launched = False
 
     def qmp(self, cmd, conv_keys=True, **args):
-        '''Invoke a QMP command and return the response dict'''
+        """
+        Invoke a QMP command and return the response dict
+        """
         qmp_args = dict()
         for key, value in args.items():
             if conv_keys:
@@ -356,11 +369,11 @@ class QEMUMachine(object):
         return self._qmp.cmd(cmd, args=qmp_args)
 
     def command(self, cmd, conv_keys=True, **args):
-        '''
+        """
         Invoke a QMP command.
         On success return the response dict.
         On failure raise an exception.
-        '''
+        """
         reply = self.qmp(cmd, conv_keys, **args)
         if reply is None:
             raise qmp.qmp.QMPError("Monitor is closed")
@@ -369,13 +382,17 @@ class QEMUMachine(object):
         return reply["return"]
 
     def get_qmp_event(self, wait=False):
-        '''Poll for one queued QMP events and return it'''
+        """
+        Poll for one queued QMP events and return it
+        """
         if len(self._events) > 0:
             return self._events.pop(0)
         return self._qmp.pull_event(wait=wait)
 
     def get_qmp_events(self, wait=False):
-        '''Poll for queued QMP events and return a list of dicts'''
+        """
+        Poll for queued QMP events and return a list of dicts
+        """
         events = self._qmp.get_events(wait=wait)
         events.extend(self._events)
         del self._events[:]
@@ -383,7 +400,7 @@ class QEMUMachine(object):
         return events
 
     def event_wait(self, name, timeout=60.0, match=None):
-        '''
+        """
         Wait for specified timeout on named event in QMP; optionally filter
         results by match.
 
@@ -391,7 +408,7 @@ class QEMUMachine(object):
         branch processing on match's value None
            {"foo": {"bar": 1}} matches {"foo": None}
            {"foo": {"bar": 1}} does not matches {"foo": {"baz": None}}
-        '''
+        """
         def event_match(event, match=None):
             if match is None:
                 return True
@@ -424,29 +441,29 @@ class QEMUMachine(object):
         return None
 
     def get_log(self):
-        '''
+        """
         After self.shutdown or failed qemu execution, this returns the output
         of the qemu process.
-        '''
+        """
         return self._iolog
 
     def add_args(self, *args):
-        '''
+        """
         Adds to the list of extra arguments to be given to the QEMU binary
-        '''
+        """
         self._args.extend(args)
 
     def set_machine(self, machine_type):
-        '''
+        """
         Sets the machine type
 
         If set, the machine type will be added to the base arguments
         of the resulting QEMU command line.
-        '''
+        """
         self._machine = machine_type
 
     def set_console(self, device_type=None):
-        '''
+        """
         Sets the device type for a console device
 
         If set, the console device and a backing character device will
@@ -464,7 +481,7 @@ class QEMUMachine(object):
         @param device_type: the device type, such as "isa-serial"
         @raises: QEMUMachineAddDeviceError if the device type is not given
                  and can not be determined.
-        '''
+        """
         if device_type is None:
             if self._machine is None:
                 raise QEMUMachineAddDeviceError("Can not add a console device:"
-- 
2.18.0.rc1.1.g3f1ff2140
